#!/usr/bin/env python3
from pathlib import Path
import re, sys

ROOT = Path(__file__).resolve().parents[1]
REQUIRED = [
    'pack.pl','README.md','INSTALL.md','LICENSE','app/antisipasipejabat.pl',
    'prolog/antisipasipejabat.pl','prolog/ap_model.pl','prolog/ap_cli.pl',
    'docs/METODOLOGI.md','docs/CARA_PAKAI.md','docs/REFERENSI.md',
    'test/run_tests.pl'
]
VERSION = '0.1.0.0'
errors=[]; warnings=[]

for rel in REQUIRED:
    if not (ROOT/rel).is_file(): errors.append(f'missing: {rel}')

for p in ROOT.rglob('*'):
    if not p.is_file(): continue
    try: text=p.read_text(encoding='utf-8')
    except UnicodeDecodeError:
        errors.append(f'non-utf8: {p.relative_to(ROOT)}'); continue
    if '\x00' in text: errors.append(f'NUL byte: {p.relative_to(ROOT)}')
    if p.suffix == '.pl':
        # Basic lexical audit, intentionally not a replacement for SWI compiler.
        # Raw delimiter count avoids treating '%' inside quoted format strings as comments.
        stripped = text
        for a,b,name in [('(',')','paren'),('[',']','bracket'),('{','}','brace')]:
            if stripped.count(a) != stripped.count(b):
                errors.append(f'unbalanced {name}: {p.relative_to(ROOT)} ({stripped.count(a)} vs {stripped.count(b)})')
        if p.parent.name == 'prolog' and ':- module(' not in text:
            errors.append(f'no module declaration: {p.relative_to(ROOT)}')

# Guardrail keyword audit: core must not grow individual-targeting features silently.
joined='\n'.join((ROOT/p).read_text(encoding='utf-8',errors='ignore').lower()
                 for p in ['prolog/ap_model.pl','prolog/ap_cli.pl','prolog/ap_simulation.pl'])
for banned in ['face recognition','pengenalan wajah','doxxing','alamat rumah aktivis','target aktivis']:
    if banned in joined: errors.append(f'guardrail keyword present in core: {banned}')

for p in [ROOT/'pack.pl', ROOT/'prolog/ap_version.pl', ROOT/'README.md', ROOT/'CHANGELOG.md']:
    if VERSION not in p.read_text(encoding='utf-8'):
        errors.append(f'version mismatch/missing in {p.relative_to(ROOT)}')

print('ANTISIPASI PEJABAT STATIC AUDIT')
print(f'root: {ROOT}')
print(f'files: {sum(1 for p in ROOT.rglob("*") if p.is_file())}')
for w in warnings: print('WARN:',w)
for e in errors: print('FAIL:',e)
if errors:
    print(f'RESULT: FAIL ({len(errors)} error)'); sys.exit(1)
print('RESULT: PASS')
