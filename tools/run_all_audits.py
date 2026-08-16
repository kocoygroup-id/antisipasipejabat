#!/usr/bin/env python3
"""Jalankan semua audit build-time yang tidak membutuhkan SWI-Prolog."""
from pathlib import Path
import subprocess, sys
ROOT = Path(__file__).resolve().parents[1]
TOOLS = [
    "audit_static.py",
    "dependency_audit.py",
    "model_mirror_audit.py",
    "release_check.py",
]
for tool in TOOLS:
    print(f"\n== {tool} ==", flush=True)
    subprocess.run([sys.executable, str(ROOT / "tools" / tool)], cwd=ROOT, check=True)
print("\nALL BUILD-TIME AUDITS: PASS")
