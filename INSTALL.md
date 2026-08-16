# Instalasi Antisipasi Pejabat

## Prasyarat

- SWI-Prolog >= 9.1.18
- Linux, Windows, atau macOS yang dapat menjalankan SWI-Prolog
- Tidak membutuhkan Python, Node.js, database server, atau internet saat runtime

## Linux / macOS

Source `.tar.Z`:

```text
tar -xzf AntisipasiPejabat-0.1.0.0.tar.Z
cd antisipasipejabat
swipl pack install .
swipl antisipasipejabat
```

Atau install langsung archive pack resmi yang ikut dirilis:

```text
swipl pack install ./antisipasipejabat-0.1.0.0.tgz
swipl antisipasipejabat
```

## Windows

Extract arsip dengan 7-Zip/alat yang mendukung gzip tar, buka PowerShell/CMD pada folder proyek:

```text
swipl pack install .
swipl antisipasipejabat
```

Jika `swipl` tidak ditemukan, tambahkan direktori `bin` SWI-Prolog ke `PATH`.

## Setelah dipublikasikan ke registry

```text
swipl pack install antisipasipejabat
swipl antisipasipejabat
```

Upgrade dan hapus:

```text
swipl pack install --upgrade antisipasipejabat
swipl pack info antisipasipejabat
swipl pack remove antisipasipejabat
```

## Tes

Dari root source:

```text
swipl -p library=prolog -q -s test/run_tests.pl
```

atau setelah pack terpasang:

```text
swipl -q -s test/run_tests.pl
```

## Audit statis source

```text
python3 tools/run_all_audits.py
```

Catatan: file `.tar.Z` rilis ini adalah **gzip-compressed tar stream** agar konsisten dengan pola distribusi yang dapat diekstrak memakai `tar -xzf`.
