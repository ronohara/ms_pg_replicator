# PostgreSQL Replicator - Changelog

## Version 1.40 (2026-06-01)

### Added
- `--create-views` command line option to create sane views on an existing PostgreSQL database without schema changes or data copy
- `--simple-names` command line option to create tables and columns with simple lowercase names (no quoted identifiers, spaces replaced with underscores)
- `--create-views` can now be used with `--schema` (not mutually exclusive) to create schema then views in one operation
- `internal_replicator_data` metadata table to record whether `--simple-names` mode was used during schema creation
- `create_internal_replicator_table()` method to create the metadata table
- `read_internal_re