#!/usr/bin/env bash
set -euo pipefail

echo "==> Creating Python venv"
python3 -m venv .venv-bim
source .venv-bim/bin/activate

echo "==> Installing ifc2duckdb"
pip install ifc2duckdb

echo "==> Downloading sample IFC"
wget -O 01-duplex.ifc \
  https://raw.githubusercontent.com/pascalorg/editor/main/apps/ifc-converter/public/test-ifc-files/01-duplex.ifc

echo "==> Converting IFC to DuckDB"
ifc2duckdb 01-duplex.ifc --database duplex.duckdb --no-geometry --verbose

echo "==> Building benchmark schema"
duckdb benchmarks.duckdb < sql/bench_schema.sql

echo "==> Loading project facts"
duckdb benchmarks.duckdb < sql/bench_facts.sql

echo "==> Verifying"
duckdb benchmarks.duckdb < sql/verify.sql

echo "==> Done. Database: benchmarks.duckdb"
