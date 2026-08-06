@echo off
REM === PYT01: TestHarness Python reference (Phase 1 only) ===
chcp 65001 >nul
set PGPASSWORD=syhunkea

echo Dropping and recreating pg_ref_harness...
psql -h x360.sentuny.com -p 5432 -U replicator -d postgres -c "DROP DATABASE IF EXISTS pg_ref_harness" 2>nul
psql -h x360.sentuny.com -p 5432 -U replicator -d postgres -c "CREATE DATABASE pg_ref_harness"
if errorlevel 1 (echo FAILED - create DB & exit /b 1)

echo Running pg_replicator.py reference...
set PYTHONIOENCODING=utf-8
python src\pg_replicator.py -c tests\ref_pg_harness.yaml -v
if errorlevel 1 (echo FAILED - python reference & exit /b 2)

echo Dumping pg_ref_harness...
pg_dump -h x360.sentuny.com -p 5432 -U replicator pg_ref_harness > tests\py_harness_dump.sql
if errorlevel 1 (echo FAILED - pg_dump & exit /b 3)

echo === DUMPS READY - PYT01 Phase 1 ===
