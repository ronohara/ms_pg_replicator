# Changelog

All notable changes to the MSAccess Replicator project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Cross-repo versioning: `VERSION` file (0.3.0) and `scripts/set_version.py` to update version markers in all three replicators
- Test harness: `tests/ref_pg_harness.yaml`, `tests/ref_ms_harness.yaml`, `tests/ref_my_harness.yaml` — per-backend configs for TestHarness.accdb
- Test harness batch scripts: `tests/py_test_harness.bat`, `tests/ms_test_harness.bat`, `tests/my_test_harness.bat` — PGT01/MST01/MYT01 Phase 1

### Changed
- Migrated per-backend changelogs to `docs/ms_changelog.md`, `docs/my_changelog.md`, `docs/pg_changelog.md`
- `__version__` marker in all three `src/*.py` for automated version bumping via `scripts/set_version.py`

### Fixed
- **dbGUID wrapper stripping** — DAO returns GUID values wrapped as `{guid {...}}`. All three replicators now strip this wrapper in `convert_dao_value_to_python()` before passing to the target database. (PGT01: guid_types 3/3 ✓, MST01: guid_types 3/3 ✓)
- **MySQL GUID braces overflow CHAR(36)** — After stripping `{guid {...}}`, 38-character braced GUIDs overflowed MySQL `CHAR(36)`. Added brace-stripping in `my_replicator.py`'s `convert_dao_value_to_python()`. (MYT01: guid_types 3/3 ✓)
- **MySQL TINYINT signed overflow for Access Byte** — Access DAO type 2 (`dbByte`, 0–255) mapped to signed `TINYINT` (−128 to 127). Changed to `TINYINT UNSIGNED` in `my_replicator.py`. (MYT01: integer_types 4/4 ✓)

### Removed
- N/A

