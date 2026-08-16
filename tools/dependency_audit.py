#!/usr/bin/env python3
from pathlib import Path
import re, sys
ROOT=Path(__file__).resolve().parents[1]
PROLOG=ROOT/'prolog'
errors=[]
mods={p.stem:p for p in PROLOG.glob('*.pl')}
for p in list(PROLOG.glob('*.pl'))+[ROOT/'app/antisipasipejabat.pl']:
    text=p.read_text(encoding='utf-8')
    for m in re.finditer(r':-\s*use_module\((ap_[a-z0-9_]+)\)\.', text):
        dep=m.group(1)
        if dep not in mods:
            errors.append(f'{p.relative_to(ROOT)} -> missing local module {dep}')
# Public module should exist and key predicates should be textually present.
public=PROLOG/'antisipasipejabat.pl'
t=public.read_text(encoding='utf-8')
for pred in ['main','start','simulate','score','default_scenario','version']:
    if not re.search(rf'\b{pred}\s*\(', t) and not re.search(rf'\b{pred}\s*:-', t):
        errors.append(f'public predicate not visibly defined: {pred}')
print('DEPENDENCY AUDIT')
print('local modules:',len(mods))
for e in errors: print('FAIL:',e)
if errors: sys.exit(1)
print('RESULT: PASS')
