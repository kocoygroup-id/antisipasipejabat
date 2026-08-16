# Validation Report — Antisipasi Pejabat v0.1.0.0

Tanggal release candidate: 17 Agustus 2026.

## Status

**STATIC-AUDITED / MODEL-MIRROR-AUDITED / ARCHIVE-INTEGRITY-CHECKED**

Release ini **belum boleh disebut runtime-tested di environment build ini** karena executable `swipl` tidak tersedia pada container yang digunakan untuk membuat arsip. Karena itu dokumentasi sengaja tidak mengklaim suite PL-Unit sudah dieksekusi di sini.

## Audit yang dijalankan

### 1. Static source audit

`python3 tools/audit_static.py`

Memeriksa UTF-8, NUL/tab tak disengaja, delimiter/quote dasar, struktur module/entrypoint, versi, file wajib, serta guardrail source.

### 2. Dependency/source graph audit

`python3 tools/dependency_audit.py`

Memeriksa import lokal, module file yang dirujuk, dan ketergantungan source internal.

### 3. Mathematical mirror audit

`python3 tools/model_mirror_audit.py`

Mirror independen formula utama mengecek 25.000 skenario acak untuk bounds dan sanity. Audit ini berguna untuk menangkap formula yang keluar rentang 0–100, tetapi **bukan pengganti eksekusi SWI-Prolog**.

### 4. Release manifest audit

`python3 tools/release_check.py`

Memeriksa struktur distribusi dan menghasilkan `SHA256SUMS` untuk source tree.

### 5. Archive extraction / checksum audit

Pada proses packaging akhir, `.tar.Z` dan `.tgz` diekstrak ulang ke direktori bersih; audit statis dijalankan lagi pada hasil ekstraksi dan checksum arsip dibuat.

## Suite runtime yang disediakan

Pada mesin Windows/Linux dengan SWI-Prolog >= 9.1.18:

```text
swipl -p library=prolog -q -s test/run_tests.pl
```

Test mencakup:

- bounds 0–100;
- monotonic sanity low-vs-high scenario;
- confidence cap;
- crowd bucket regression;
- interpretasi legal note tentang notification;
- save/load roundtrip tanpa `consult`;
- deterministic 7-day simulation seed.

## Klaim yang TIDAK dibuat

- v0.1 bukan probabilitas empiris terkalibrasi.
- v0.1 bukan model kausal.
- v0.1 tidak menjanjikan akurasi tertentu pada kejadian masa depan.
- dataset contoh adalah sintetis.
- casebook historis adalah referensi desain, bukan training set.

## Checklist sebelum penggunaan riset/operasional

1. Jalankan PL-Unit pada host target.
2. Gunakan dataset historis berlabel dengan definisi konsisten.
3. Pisahkan train/validation/test secara temporal.
4. Bandingkan dengan baseline sederhana.
5. Laporkan Brier score dan calibration plot, bukan accuracy saja.
6. Dokumentasikan provenance setiap variabel.
7. Lakukan error audit lintas wilayah dan waktu.
8. Jangan mengubah output menjadi profiling individu atau daftar target pengawasan.
