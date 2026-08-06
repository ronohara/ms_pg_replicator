@echo off
REM === MYT01: TestHarness my_replicator.py reference (Phase 1 only) ===
chcp 65001 >nul

echo Dropping and recreating my_ref_harness...
mysql -h x360.sentuny.com -P 3306 -u replicator -pbluewhale$54321 -e "DROP DATABASE IF EXISTS my_ref_harness; CREATE DATABASE my_ref_harness CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci" 2>nul
if errorlevel 1 (echo FAILED - create DB & exit /b 1)

echo Running my_replicator.py reference...
set PYTHONIOENCODING=utf-8
python src\my_replicator.py -c tests\ref_my_harness.yaml -v
if errorlevel 1 (echo FAILED - python reference & exit /b 2)

echo Dumping my_ref_harness...
mysqldump -h x360.sentuny.com -P 3306 -u replicator -pbluewhale$54321 --no-tablespaces my_ref_harness > tests\my_harness_dump.sql
if errorlevel 1 (echo FAILED - dump & exit /b 3)

echo === DUMPS READY - MYT01 Phase 1 ===
