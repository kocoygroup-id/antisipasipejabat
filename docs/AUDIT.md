# Audit dan Reproducibility

## Runtime audit

Setiap simulasi interaktif menulis satu baris ke `~/.antisipasipejabat/audit.log`:

- timestamp
- `term_hash` skenario
- likelihood
- spread
- escalation
- confidence

Log tidak menyimpan nama orang, kontak, atau isi lengkap skenario.

## Source audit

`tools/audit_static.py` memeriksa:

- UTF-8
- tidak ada tab/NUL tak sengaja
- keseimbangan bracket/quote dasar pada `.pl`
- semua module file memiliki deklarasi module atau entrypoint yang sesuai
- larangan keyword berisiko di kode inti (profiling individu / doxxing)
- keberadaan file wajib
- konsistensi versi

`tools/dependency_audit.py` memeriksa graph module/import lokal.

`tools/model_mirror_audit.py` menjalankan mirror matematis independen pada puluhan ribu skenario acak untuk bounds/sanity.

`tools/release_check.py` memeriksa struktur pack, file app, dokumentasi, contoh, test, dan membuat manifest SHA-256.

Semua audit build-time dapat dijalankan dengan `python3 tools/run_all_audits.py`.

## Unit test SWI-Prolog

```text
swipl -p library=prolog -q -s test/run_tests.pl
```

Test mencakup bounds, sanity monotonic, confidence cap, bucket turnout, legal-note regression, I/O roundtrip, dan deterministic seed.

## Klaim stabilitas

Release boleh disebut "static-audited" jika script audit lulus. Sebutan "runtime-tested" hanya boleh dipakai setelah suite SWI-Prolog benar-benar dieksekusi pada host target.


Lihat `docs/VALIDATION_REPORT.md` untuk status audit release ini dan batas klaim runtime.
