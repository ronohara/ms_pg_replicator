@echo off
REM === MST01: TestHarness ms_replicator.py reference (Phase 1 only) ===
chcp 65001 >nul

echo Dropping and recreating ms_ref_harness...
sqlcmd -S localhost -U replicator -P "Syhunkea$1954" -Q "IF EXISTS (SELECT name FROM sys.databases WHERE name = 'ms_ref_harness') BEGIN ALTER DATABASE ms_ref_harness SET SINGLE_USER WITH ROLLBACK IMMEDIATE; DROP DATABASE ms_ref_harness; END CREATE DATABASE ms_ref_harness"
if errorlevel 1 (echo FAILED - create DB & exit /b 1)

echo Running ms_replicator.py reference...
set PYTHONIOENCODING=utf-8
python src\ms_replicator.py -c tests\ref_ms_harness.yaml -v
if errorlevel 1 (echo FAILED - python reference & exit /b 2)

echo Dumping ms_ref_harness...
set MSSQL_SCRIPTER_PASSWORD=Syhunkea$1954
call mssql-scripter -S localhost -d ms_ref_harness -U replicator --schema-and-data -f Z:\msaccess_replicator\tests\ms_harness_dump.sql
if errorlevel 1 (echo FAILED - dump & exit /b 3)

echo === DUMPS READY - MST01 Phase 1 ===
