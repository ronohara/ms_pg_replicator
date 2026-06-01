# MS SQL Server Replicator - Changelog

## Version 1.12 (2026-06-01)

### Added
- `--create-views` command line option to create sane views on an existing SQL Server database without schema changes or data copy
- `--simple-names` command line option to create tables and columns with simple lowercase names (no quoted identifiers, spaces replaced with underscores)
- `--create-views` can now be used with `--schema` (not mutually exclusive) to create schema then views in one operation
- `internal_replicator_data` metadata table to record whether `--simple-names` mode was used during schema creation
- `create_internal_replicator_table()` method to create the metadata table
- `read_internal_replicator_data()` method to read the `simplenames` setting from the database
- `get_sanitise_function()` method that returns either `sanitise_token_for_sqlserver` (quoted mode) or `sanitise_for_sane_view` (simple names mode) based on the `simple_names` flag
- `create_sane_views()` method to create views after schema replication (opens its own connections)
- `create_views_only()` method to create views on an existing database (auto-detects naming mode)
- Special character handling in `sanitise_for_sane_view()`:
  - `%` → `_percent`
  - `$` → `dollar_`, `_dollar_`, or `_dollar` based on position
  - `#` → `hash_`, `_hash_`, or `_hash` based on position
  - `@` → `at_`, `_at_`, or `_at` based on position
  - `&` → `amp_`, `_amp_`, or `_amp` based on position
  - `*` → `star_`, `_star_`, or `_star` based on position
  - `+` → `plus_`, `_plus_`, or `_plus` based on position
  - `-` → `minus_`, `_minus_`, or `_minus` based on position
  - `(` → `lbrk_`, `_lbrk_`, or `_lbrk` based on position
  - `)` → `rbrk_`, `_rbrk_`, or `_rbrk` based on position
- Leading digit handling in `sanitise_for_sane_view()` (prefixes with underscore)

### Changed
- Default configuration file name changed from `ms_replicatorconfig.yaml` to `replicatorconfig.yaml` (consistent with pg_replicator)
- `create_views_only()` now reads `simplenames` from `internal_replicator_data` to determine naming mode for table lookups
- `create_views_only()` now opens both MS Access and SQL Server connections (was SQL Server only)
- `create_sane_views()` now opens its own connections (was assuming connections were already open, causing failures when used after `replicate_schema()`)
- `create_sane_views()` and `create_views_only()` now use `col['name']` (the sanitised column identifier) in the SELECT clause instead of quoting the original column name
- `check_primary_key()`, `check_unique_constraint_only()`, and `check_reference_table_has_uniqueness()` now sanitise column names before comparing with SQL Server schema (fixes foreign key detection when `--simple-names` is active)
- `create_foreign_key()` now correctly handles the case where `ensure_uniqueness_on_base_table()` returns `None`, logging an error and skipping instead of entering an infinite recursive loop
- `create_all_indexes()` now uses the sanitised table name for existence checks instead of the original Access table name
- `create_foreign_key()` existence check now uses the sanitised table name
- `load_table()` now uses `get_sanitise_function()` to determine the appropriate sanitisation method
- All SQL generation now respects the `simple_names` flag via the dynamic sanitisation function
- `--create-views` removed from mutually exclusive group, allowing it to be used with `--schema`
- Views now use `CREATE OR ALTER VIEW` (SQL Server 2016+ syntax)

### Removed
- `column_mapping` references (undocumented feature that was never requested, removed for consistency with pg_replicator)

### Fixed
- Foreign key infinite loop when neither referenced table has a PRIMARY KEY or UNIQUE constraint
- Column name collisions in simple-names mode (e.g., `nadir` and `nadir%` now become `nadir` and `nadir_percent`)
- Identifiers starting with digits in simple-names mode now correctly prefixed with underscore
- `create_views_only()` now uses the correct table name when the database was created with `--simple-names`
- Index creation existence check now correctly identifies existing indexes when `--simple-names` is active
- Foreign key existence check now correctly identifies existing foreign keys when `--simple-names` is active
- Trailing underscore stripping in `sanitise_for_sane_view` no longer removes meaningful underscores (e.g., `nadir_` from `nadir%` is preserved)
- `--create-views` no longer incorrectly placed in mutually exclusive group with `--schema`
- `create_sane_views()` no longer fails with connection errors when called after `replicate_schema()` because it now opens its own connections

---

## Version 1.11 (2026-05-28)

### Added
- `exit_program()` centralized shutdown method with connection cleanup and logging
- Log entry at program start recording version number
- Defensive exception handling in `close_connections()` for each connection type
- Connection handles set to None after closing in `close_connections()` and `test_network_connections()`

### Changed
- All `sys.exit(1)` calls replaced with `self.exit_program(1, error_msg)` for consistent shutdown handling
- `exit_and_cleanup()` simplified to call `exit_program(0)` instead of inline cleanup
- Main exception handler now uses `manager.exit_program()` when manager exists, with fallback for pre-manager errors
- `table_exists_in_sqlserver()` now uses string concatenation instead of parameterized queries
- `row_exists_in_sqlserver()` now uses string concatenation instead of parameterized queries
- `check_primary_key()` now uses string concatenation instead of parameterized queries
- `check_unique_constraint_only()` now uses string concatenation instead of parameterized queries
- `check_reference_table_has_uniqueness()` now uses string concatenation instead of parameterized queries
- `_sync_deleted_table()` SELECT and DELETE queries now use string concatenation instead of parameterized queries
- `create_all_indexes()` existence check now uses string concatenation instead of parameterized queries
- `create_foreign_key()` existence check now uses string concatenation instead of parameterized queries
- `merge_row()` MERGE statement now uses string concatenation instead of parameterized queries
- `replicate_schema()` database creation now uses string concatenation with proper escaping
- `ss_sql_execute()` method signature simplified (removed `params` parameter)

### Fixed
- Connection cleanup now occurs consistently on all exit paths
- Error messages now properly logged before program termination in all scenarios
- DAO connection warning "Object invalid or no longer set" now handled gracefully (logged at debug level)
- Connection handles now properly set to None after closing to prevent double-close attempts

---

## Version 1.10 (2026-05-27)

### Added
- `scanned_tables` set to track which tables have been processed during sync-deleted
- `get_sqlserver_row_count()` helper method for reusable row count queries
- `get_parent_tables()` method to dynamically retrieve parent tables for a given child by scanning foreign keys
- Dependency-based iteration in `sync_deleted_tables()` for fast mode

### Changed
- `sync_deleted_tables()` now processes tables in dependency order (parents before children) when `--slow` is NOT enabled
- A table is only processed for deletion scanning when ALL its parent tables have already been scanned
- Tables with no parent dependencies are processed first
- Cascade deletions from parent tables can eliminate the need to scan child tables entirely
- Added diagnostic debug logging for tables waiting on parents

---

## Version 1.9 (2026-05-26)

### Fixed
- `None` handling in `get_all_tables_to_process()` - converts `None` to empty list when `tables:` section exists but is empty
- `None` handling in `copy_table()` - converts `None` to empty list when `nonvolatile:` section exists but is empty
- `None` handling in `generate_yaml_file()` - converts `None` to empty list for both `tables` and `nonvolatile` sections
- Error when `tables:` entry exists but is `None` (empty YAML section) causing type error

### Changed
- Auto-discovered tables are now included in generated YAML when `tables:` section is missing or `None`
- Existing tables configuration is preserved when `tables:` section has content
- Nonvolatile entries are preserved in generated YAML when they exist

---

## Version 1.8 (2026-05-26)

### Added
- Total elapsed runtime display at program completion (HH:MM:SS format, matching table-level output)
- `program_start_time` attribute to track overall execution time
- Slow mode now overrides nonvolatile optimization (copies tables even when row counts match)

### Changed
- `--slow` option no longer restricted to `--sync-deleted` only
- Non-volatile tables are now copied when `--slow` is enabled, regardless of row count match
- Added diagnostic messages for slow mode: "SLOW MODE: copying anyway (optimization disabled for debugging)"
- Added "SLOW MODE enabled - full sync" suffix to table sync messages
- Updated command line help text for `--slow` and `--nonvolatile` options

### Fixed
- Removed error condition that required `--slow` to be used with `--sync-deleted`

---

## Version 1.7 (2026-05-26)

### Added
- Filtered unique index support for nullable columns
- Detection of nullable columns when creating unique indexes
- Automatic creation of filtered unique indexes (WHERE column IS NOT NULL) when all columns in a unique index are nullable
- Logging to indicate when filtered unique indexes are created

### Changed
- Unique indexes on nullable columns now use filtered index syntax
- Multiple NULL values are now allowed in unique indexes (matches MS Access behavior)
- Uniqueness is still enforced for non-NULL values

---

## Version 1.6 (2026-05-25)

### Fixed
- Indentation error in `copy_table()` method that caused syntax errors

### Changed
- Modified `_create_unique_constraint_on_base_table()` to no longer create unnecessary unique constraints on child tables
- Modified `ensure_uniqueness_on_base_table()` to skip automatic creation of unique constraints on child side of foreign keys
- Added warning logs when unique constraint creation is skipped

---

## Version 1.5 (2026-05-25)

### Added
- `row_exists_in_sqlserver()` method to check if a row exists by its key columns
- Detailed logging for rejected rows including key values
- Counters for duplicate skipped and duplicate rejected

### Changed
- Enhanced `merge_row()` to return result_type: SUCCESS, DUPLICATE_EXISTS, DUPLICATE_REJECTED, FK_VIOLATION, ERROR
- When duplicate key error occurs, now checks if row actually exists in target
- Duplicate key error with existing row → DUPLICATE_EXISTS (safe skip)
- Duplicate key error with missing row → DUPLICATE_REJECTED (counted as failure, logged as warning)
- Completion message now shows both duplicates skipped (exists) and duplicates rejected (missing)
- Validation summary now written to log file (previously only console)

---

## Version 1.4 (2026-05-25)

### Added
- Enhanced `merge_row()` return tuple (inserted, result_type, details)
- Counters for duplicate skipped and duplicate rejected
- Validation summary now written to log file

### Changed
- Improved error tracking in `copy_table()`
- Completion message now shows duplicate counts and FK violations

---

## Version 1.3 (2026-05-25)

### Fixed
- MERGE statement syntax: added source. prefix for INSERT values
- NULL key handling: rows with NULL keys now use INSERT instead of MERGE
- Duplicate key detection (error 2601) now handled gracefully

### Changed
- `merge_row()` returns tuple with inserted flag and additional status flags

---

## Version 1.2 (2026-05-25)

### Fixed
- Data type mapping for dbText fields now uses NVARCHAR(255) or field-specific size instead of NVARCHAR(MAX)
- Index compatibility check added to skip indexes on MAX types (NVARCHAR(MAX), VARBINARY(MAX)) and incompatible types (TEXT, NTEXT, IMAGE, XML)

### Added
- Warning logs when index creation is skipped due to incompatible column types
- Try-except in index creation to continue with remaining indexes if one fails

---

## Version 1.1 (2026-05-25)

### Added
- `open_sqlserver_connection_master()` method for network testing
- Connection to master database when `--network` flag is specified

### Changed
- Modified `test_network_connections()` to use `open_sqlserver_connection_master()` instead of `open_sqlserver_connection()`

---

## Version 1.0 (2026-05-25)

### Initial port from PostgreSQL replicator (pg_replicator.py v1.35)

**Changes made from PostgreSQL version:**
- Connection library: psycopg2 → pymssql
- Configuration section: postgresql: → sqlserver:
- Command line options: --thost, --tport, etc. → --shost, --sport, etc.
- Identifier quoting: double quotes "name" → square brackets [name]
- Data type mappings for SQL Server compatibility
- UPSERT: ON CONFLICT ... DO UPDATE → MERGE statement
- Pagination: LIMIT with tuple comparison → OFFSET ... FETCH NEXT
- System catalog queries: pg_* tables → sys.* views
- DROP TABLE CASCADE → DROP TABLE without CASCADE (tables dropped in reverse dependency order)
- Schema: public → dbo
- Log file: replicator.log → ms_replicator.log
- Default config file: replicatorconfig.yaml → ms_replicatorconfig.yaml (changed back in v1.12)

**Features preserved:**
- `--nonvolatile` optimization
- `--sync-deleted` deletion synchronization
- `--slow` mode (originally only for sync-deleted, expanded in v1.8)
- `--no-auto-index` foreign key handling
- Transformations (MMH3, yearonly, drop)
- Foreign key discovery from MS Access relationships
- Validation and reporting
- Batch processing for deletions
- Progress bars with ETA

---

## Command Line Options Summary

| Option | Description |
|--------|-------------|
| `-c, --config` | Path to configuration file (default: replicatorconfig.yaml) |
| `-s, --source` | MS Access database file name |
| `--shost` | SQL Server host name or IP |
| `--sport` | SQL Server port number |
| `--sdatabase` | SQL Server database name |
| `--suser` | SQL Server user name |
| `--spassword` | SQL Server password |
| `-v, --verbose` | Print informational messages |
| `--debug` | Enable SQL debugging output |
| `--trace` | Enable trace logging to file |
| `-a, --no-auto-index` | Suppress automatic creation of indexes/constraints for foreign keys |
| `--sync-deleted` | Synchronize deleted records from Access to SQL Server |
| `--slow` | Use slower processing; disables nonvolatile optimization |
| `--nonvolatile` | Skip copying non-volatile tables when row counts match (unless --slow is also enabled) |
| `-S, --schema` | Drop and recreate database, then replicate schema ONLY |
| `--create-views` | Create sane views on existing database (no schema changes, no data copy). When used with --schema, creates schema THEN views. |
| `--simple-names` | Create tables and columns with simple lowercase names (no quoted identifiers). Can only be used with --schema. |
| `--adjust-ms-access` | Adjust MS Access schema (add AutoNumber primary key to tables without PK) |
| `-l, --list` | List table names and exit |
| `-n, --network` | Test both source and target connections |
| `--dump` | Dump internal program data |
| `--full-refresh` | Perform full refresh (drop and recreate all tables) |
| `-V, --version` | Show version and exit |
| `-o, --output` | Output file for generated YAML configuration |

---

## Version Format

Version numbers follow semantic versioning where practical:
- Major (1.x.x) – Significant changes, potential breaking changes
- Minor (x.1.x) – New features, backward compatible
- Patch (x.x.1) – Bug fixes, backward compatible

## File Locations

| File | Description |
|------|-------------|
| ms_replicator.py | Main program |
| ms_replicator.log | Runtime log file |
| replicatorconfig.yaml | Configuration file (shared with pg_replicator) |

## Version History Summary

| Version | Date | Focus |
|---------|------|-------|
| 1.0 | 2026-05-25 | Initial port from PostgreSQL |
| 1.1 | 2026-05-25 | Network testing with master database |
| 1.2 | 2026-05-25 | Data type fixes, index compatibility |
| 1.3 | 2026-05-25 | MERGE syntax, NULL key handling |
| 1.4 | 2026-05-25 | Enhanced result tracking, logging |
| 1.5 | 2026-05-25 | Row existence checking, duplicate handling |
| 1.6 | 2026-05-25 | Skip auto UNIQUE constraints on child tables |
| 1.7 | 2026-05-26 | Filtered unique indexes for nullable columns |
| 1.8 | 2026-05-26 | Extended --slow option, total elapsed time |
| 1.9 | 2026-05-26 | None handling in configuration sections |
| 1.10 | 2026-05-27 | Dependency-based sync-deleted processing |
| 1.11 | 2026-05-28 | Centralized exit handling, string concatenation |
| 1.12 | 2026-06-01 | Simple names mode, view creation, shared config, column_mapping removal, connection fix for create_sane_views |

---

## Notes

- This program targets SQL Server as the destination database
- Row-by-row processing and string concatenation for SQL are deliberate design choices
- The program is Windows-only due to DAO dependency for MS Access access
- When `--simple-names` is used during schema creation, subsequent replication runs automatically detect and use simple naming mode via the `internal_replicator_data` table
- Special character replacements in simple-names mode use descriptive words (e.g., `%` becomes `_percent`, `$` becomes `_dollar_`, `(` becomes `_lbrk_`, `)` becomes `_rbrk_`) to avoid collisions and maintain readability
- `--create-views` is no longer mutually exclusive with `--schema`, allowing both to be used together for one-step schema and view creation
- All replicator programs (pg_replicator, ms_replicator, my_replicator) now share the same default configuration file name (`replicatorconfig.yaml`) for consistency
- `create_sane_views()` now properly opens its own connections, fixing the connection errors that occurred when called after `replicate_schema()`