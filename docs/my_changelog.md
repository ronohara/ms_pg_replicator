# MySQL Replicator - Changelog

## Version 1.2 (2026-06-01)

### Added
- `--create-views` command line option to create sane views on an existing MySQL database without schema changes or data copy
- `--simple-names` command line option to create tables and columns with simple lowercase names (no quoted identifiers, spaces replaced with underscores)
- `--create-views` can now be used with `--schema` (not mutually exclusive) to create schema then views in one operation
- `internal_replicator_data` metadata table to record whether `--simple-names` mode was used during schema creation
- `create_internal_replicator_table()` method to create the metadata table
- `read_internal_replicator_data()` method to read the `simplenames` setting from the database
- `get_sanitise_function()` method that returns either `sanitise_token_for_mysql` (quoted mode) or `sanitise_for_sane_view` (simple names mode) based on the `simple_names` flag
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
- Default configuration file name changed from `my_replicatorconfig.yaml` to `replicatorconfig.yaml` (consistent with pg_replicator and ms_replicator)
- `create_views_only()` now reads `simplenames` from `internal_replicator_data` to determine naming mode for table lookups
- `create_views_only()` now opens both MS Access and MySQL connections (was MySQL only)
- `create_sane_views()` now opens its own connections (was assuming connections were already open, causing `'NoneType' object has no attribute 'TableDefs'` error)
- `create_sane_views()` and `create_views_only()` now use `col['name']` (the sanitised column identifier) in the SELECT clause instead of quoting the original column name
- `check_primary_key()`, `check_unique_constraint_only()`, and `check_reference_table_has_uniqueness()` now sanitise column names before comparing with MySQL schema (fixes foreign key detection when `--simple-names` is active)
- `create_foreign_key()` now correctly handles the case where `ensure_uniqueness_on_base_table()` returns `None`, logging an error and skipping instead of entering an infinite recursive loop
- `create_all_indexes()` now uses the sanitised table name for existence checks instead of the original Access table name
- `create_foreign_key()` existence check now uses the sanitised table name
- `load_table()` now uses `get_sanitise_function()` to determine the appropriate sanitisation method
- All SQL generation now respects the `simple_names` flag via the dynamic sanitisation function
- `--create-views` removed from mutually exclusive group, allowing it to be used with `--schema`

### Removed
- `column_mapping` references (undocumented feature that was never requested, removed for consistency with other replicators)

### Fixed
- Foreign key infinite loop when neither referenced table has a PRIMARY KEY or UNIQUE constraint
- Column name collisions in simple-names mode (e.g., `nadir` and `nadir%` now become `nadir` and `nadir_percent`)
- Identifiers starting with digits in simple-names mode now correctly prefixed with underscore
- `create_views_only()` now uses the correct table name when the database was created with `--simple-names`
- Index creation existence check now correctly identifies existing indexes when `--simple-names` is active
- Foreign key existence check now correctly identifies existing foreign keys when `--simple-names` is active
- Trailing underscore stripping in `sanitise_for_sane_view` no longer removes meaningful underscores (e.g., `nadir_` from `nadir%` is preserved)
- `--create-views` no longer incorrectly placed in mutually exclusive group with `--schema`
- `create_sane_views()` no longer fails with `'NoneType' object has no attribute 'TableDefs'` because it now opens its own connections

---

## Version 1.1 (2026-05-28)

### Added
- `exit_program()` centralized shutdown method with connection cleanup and logging
- Log entry at program start recording version number
- Defensive exception handling in `close_connections()` for each connection type
- Connection handles set to None after closing in `close_connections()` and `test_network_connections()`

### Changed
- All `sys.exit(1)` calls replaced with `self.exit_program(1, error_msg)` for consistent shutdown handling
- `exit_and_cleanup()` simplified to call `exit_program(0)` instead of inline cleanup
- Main exception handler now uses `manager.exit_program()` when manager exists, with fallback for pre-manager errors
- PostgreSQL library (`psycopg2`) replaced with MySQL Connector (`mysql.connector`)
- Configuration section renamed from `postgresql:` to `mysql:`
- Command line options changed from `--thost`, `--tport`, etc. to `--mhost`, `--mport`, etc.
- Identifier quoting changed from double quotes to backticks
- `sanitise_token_for_postgresql()` renamed to `sanitise_token_for_mysql()` with backtick quoting
- `escape_postgresql_string()` renamed to `escape_mysql_string()`
- `convert_dao_value_to_postgresql_literal()` renamed to `convert_dao_value_to_mysql_literal()`
- `get_postgresql_row_count()` renamed to `get_mysql_row_count()`
- `table_exists_in_postgresql()` renamed to `table_exists_in_mysql()` using MySQL information_schema
- `row_exists_in_postgresql()` renamed to `row_exists_in_mysql()`
- `pg_sql_execute()` renamed to `mysql_sql_execute()` with `params` parameter removed
- `open_postgresql_connection()` renamed to `open_mysql_connection()`
- `open_postgresql_connection_master()` renamed to `open_mysql_connection_master()`
- Data type mappings converted from PostgreSQL types to MySQL types
- UPSERT syntax changed from `ON CONFLICT ... DO UPDATE` to `ON DUPLICATE KEY UPDATE`
- Pagination in `_sync_deleted_table()` changed from tuple comparison to `LIMIT ... OFFSET`
- System catalog queries converted from PostgreSQL `pg_*` tables to MySQL information_schema
- Primary key and unique constraint checks now use information_schema
- Foreign key existence checks now use information_schema
- Schema replication now uses MySQL `CREATE DATABASE` with utf8mb4 character set
- Table creation now includes `ENGINE=InnoDB` for foreign key support

### Fixed
- Connection cleanup now occurs consistently on all exit paths
- Error messages now properly logged before program termination in all scenarios
- DAO connection warning "Object invalid or no longer set" now handled gracefully (logged at debug level)
- Connection handles now properly set to None after closing to prevent double-close attempts

---

## Version 1.0 (2026-05-28)

### Initial port from PostgreSQL replicator (pg_replicator.py v1.39)

**Changes made from pg_replicator v1.39:**
- Connection library: psycopg2 → mysql.connector
- Configuration section: postgresql: → mysql:
- Command line options: --thost, --tport, etc. → --mhost, --mport, etc.
- Identifier quoting: double quotes "name" → backticks `name`
- Data type mappings for MySQL compatibility (BOOLEAN, INT, BIGINT, DATETIME, BLOB, TEXT, etc.)
- UPSERT: ON CONFLICT ... DO UPDATE → ON DUPLICATE KEY UPDATE
- Pagination: tuple comparison (col) > (val) → LIMIT ... OFFSET
- System catalog queries: pg_* tables → information_schema views
- Schema: public → DATABASE() function
- DROP TABLE CASCADE → DROP TABLE (no CASCADE needed)
- Table engine: InnoDB for foreign key support
- Character set: utf8mb4 with utf8mb4_unicode_ci collation

**Features preserved:**
- `--nonvolatile` optimization
- `--sync-deleted` deletion synchronization
- `--slow` mode (affects nonvolatile optimization and dependency resolution)
- `--no-auto-index` foreign key handling
- Transformations (MMH3, yearonly, drop)
- Foreign key discovery from MS Access relationships
- Validation and reporting
- Batch processing for deletions (OFFSET pagination)
- Progress bars with ETA
- Dependency-based sync-deleted processing (parents before children)

---

## Command Line Options Summary

| Option | Description |
|--------|-------------|
| `-c, --config` | Path to configuration file (default: replicatorconfig.yaml) |
| `-s, --source` | MS Access database file name |
| `--mhost` | MySQL server host name or IP |
| `--mport` | MySQL server port number |
| `--mdatabase` | MySQL database name |
| `--muser` | MySQL user name |
| `--mpassword` | MySQL password |
| `-v, --verbose` | Print informational messages |
| `--debug` | Enable SQL debugging output |
| `--trace` | Enable trace logging to file |
| `-a, --no-auto-index` | Suppress automatic creation of indexes/constraints for foreign keys |
| `--sync-deleted` | Synchronize deleted records from Access to MySQL |
| `--slow` | Use slower processing; disables nonvolatile optimization and dependency resolution |
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
| my_replicator.py | Main program |
| my_replicator.log | Runtime log file |
| replicatorconfig.yaml | Configuration file (shared with pg_replicator and ms_replicator) |

## Version History Summary

| Version | Date | Focus |
|---------|------|-------|
| 1.0 | 2026-05-28 | Initial port from PostgreSQL replicator |
| 1.1 | 2026-05-28 | Centralized exit handling, string concatenation, OFFSET pagination, ON DUPLICATE KEY UPDATE |
| 1.2 | 2026-06-01 | Simple names mode, view creation, shared config, column_mapping removal, mutually exclusive fix, connection fix for create_sane_views |

---

## Notes

- This program targets MySQL as the destination database
- Row-by-row processing and string concatenation for SQL are deliberate design choices
- The program is Windows-only due to DAO dependency for MS Access access
- When `--simple-names` is used during schema creation, subsequent replication runs automatically detect and use simple naming mode via the `internal_replicator_data` table
- Special character replacements in simple-names mode use descriptive words (e.g., `%` becomes `_percent`, `$` becomes `_dollar_`, `(` becomes `_lbrk_`, `)` becomes `_rbrk_`) to avoid collisions and maintain readability
- `--create-views` is no longer mutually exclusive with `--schema`, allowing both to be used together for one-step schema and view creation
- All three replicator programs (pg_replicator, ms_replicator, my_replicator) now share the same default configuration file name (`replicatorconfig.yaml`) for consistency
- `create_sane_views()` now properly opens its own connections, fixing the `'NoneType' object has no attribute 'TableDefs'` error that occurred when called after `replicate_schema()`