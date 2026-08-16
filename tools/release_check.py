#!/usr/bin/env python3
from pathlib import Path
import hashlib, sys, re
ROOT=Path(__file__).resolve().parents[1]
errors=[]

pack=(ROOT/'pack.pl').read_text(encoding='utf-8')
for token in ["name(antisipasipejabat).", "version('0.1.0.0').", "requires(prolog >= '9.1.18')."]:
    if token not in pack: errors.append(f'pack metadata missing: {token}')

app=(ROOT/'app/antisipasipejabat.pl').read_text(encoding='utf-8')
if 'initialization(main, main)' not in app:
    errors.append('pack app has no main initialization')

manifest=[]
for p in sorted(ROOT.rglob('*')):
    if p.is_file() and p.name != 'SHA256SUMS':
        h=hashlib.sha256(p.read_bytes()).hexdigest()
        manifest.append(f'{h}  {p.relative_to(ROOT).as_posix()}')
(ROOT/'SHA256SUMS').write_text('\n'.join(manifest)+'\n',encoding='utf-8')

print('RELEASE CHECK')
print('manifest entries:',len(manifest))
for e in errors: print('FAIL:',e)
if errors: sys.exit(1)
print('RESULT: PASS')
