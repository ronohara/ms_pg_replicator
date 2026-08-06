#!/usr/bin/env python3
"""Set the version string in all three Python replicators.

Reads the central VERSION file at the repo root and replaces the
__version__ marker line in each src/*.py file.

Usage:
    python scripts/set_version.py          # update all three
    python scripts/set_version.py --check  # report version without changing
"""

import sys
from pathlib import Path

MARKER = "# VERSION_MARKER"
REPO = Path(__file__).resolve().parent.parent
TARGETS = ["pg_replicator.py", "ms_replicator.py", "my_replicator.py"]


def read_version() -> str:
    return (REPO / "VERSION").read_text().strip()


def set_version(filepath: Path, version: str):
    content = filepath.read_text()
    # Replace the line containing the marker
    new_lines = []
    for line in content.splitlines(keepends=True):
        if MARKER in line:
            new_lines.append(f'__version__ = "{version}"  {MARKER}\n')
        else:
            new_lines.append(line)
    filepath.write_text("".join(new_lines))


def main():
    check_only = "--check" in sys.argv
    version = read_version()

    for target in TARGETS:
        path = REPO / "src" / target
        if "MARKER" not in path.read_text():
            print(f"ERROR: {target} — no VERSION_MARKER found. Add the marker line first.")
            sys.exit(1)

    if check_only:
        print(f"Current version: {version}")
        return

    for target in TARGETS:
        path = REPO / "src" / target
        set_version(path, version)
        print(f"  {target} → {version}")

    print(f"All three replicators set to version {version}")


if __name__ == "__main__":
    main()
