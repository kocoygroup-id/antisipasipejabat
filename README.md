# ANTISIPASI PEJABAT 💀

> ## **Uji kebijakannya dulu. Bukan kesabaran publik.**

**Indonesian Civil Demonstration Risk Simulator — full SWI-Prolog, full terminal.**

[![SWI-Prolog Pack](https://img.shields.io/badge/SWI--Prolog%20Pack-PUBLISHED-16a34a?style=for-the-badge)](https://www.swi-prolog.org/pack/list?p=antisipasipejabat)
[![Version](https://img.shields.io/badge/version-0.1.0.0-d97706?style=for-the-badge)](https://github.com/kocoygroup-id/antisipasipejabat/tags)
[![License](https://img.shields.io/badge/license-CC0--1.0-52525b?style=for-the-badge)](LICENSE)

---

## Karena kebijakan kontroversial tanpa simulasi itu mahal.

**Terutama bagi rakyat.**

Antisipasi Pejabat adalah simulator skenario kebijakan dan risiko demonstrasi Indonesia berbasis **SWI-Prolog**.

Ia dibuat untuk menjawab pertanyaan yang sering baru ditanyakan setelah keadaan memburuk:

> **“Kalau kebijakan ini benar-benar dijalankan, apa yang mungkin terjadi pada tekanan publik?”**

Bukan sekadar satu angka “bakal demo atau tidak”.

Antisipasi Pejabat memisahkan:

- **Likelihood** — seberapa kuat kondisi agregat mendukung terjadinya aksi.
- **Spread** — seberapa besar isu berpotensi menyebar lintas kelompok/wilayah.
- **Escalation** — seberapa tinggi risiko situasi memburuk.
- **Political Pressure** — seberapa besar tekanan terhadap proses kebijakan.
- **Continuation** — seberapa mungkin tekanan bertahan.
- **Confidence** — seberapa kuat kualitas input yang mendasari simulasi.

Dan yang paling penting:

> **Model menunjukkan _kenapa_ sebuah skor naik atau turun.**

Tidak ada “AI berkata 83, percaya saja”.

---

# INSTALL-JALANKAN-UJI

Antisipasi Pejabat **sudah dipublikasikan di SWI-Prolog Pack Registry**.

Install:

```bash
swipl pack install antisipasipejabat
```

Jalankan:

```bash
swipl antisipasipejabat
```

Selesai.

Tidak perlu clone repository.
Tidak perlu compile manual.
Tidak perlu menulis query Prolog untuk penggunaan normal.

Cek versi:

```bash
swipl antisipasipejabat --version
```

Bantuan:

```bash
swipl antisipasipejabat --help
```

> ❌ `swipl install antisipasipejabat`  
> ✅ `swipl pack install antisipasipejabat`

Butuh **SWI-Prolog 9.1.18+** untuk menjalankan pack application dengan `swipl antisipasipejabat`.

---

# APA YANG BISA DISIMULASIKAN?

Misalnya pemerintah ingin menguji skenario:

> **“Bagaimana kalau harga energi naik ketika tekanan ekonomi tinggi, ketidakpercayaan publik meningkat, isu viral, dan respons pemerintah lambat?”**

Masukkan kondisi tersebut.

Antisipasi Pejabat kemudian menghitung beberapa dimensi risiko secara terpisah.

Contoh bentuk hasil:

```text
============================================================
 ANTISIPASI PEJABAT - HASIL SIMULASI
============================================================

Kemungkinan aksi   : 76/100
Penyebaran         : 82/100
Eskalasi           : 51/100
Tekanan kebijakan  : 73/100
Kelanjutan aksi    : 69/100
Confidence model   : 48/68

State              : protest_with_intervention
Skala              : multi-provinsi
Turnout bucket     : large
```

Lalu model menjelaskan faktor yang paling mendorong skor:

```text
+ akumulasi keluhan
+ kekuatan pemicu
+ momentum daring
+ dukungan publik
+ relevansi lintas wilayah
```

serta faktor mitigasi yang dimodelkan:

```text
- komunikasi pemerintah
- responsivitas / dialog
```

---

# BUKAN CUMA “RAMAL DEMO”

Antisipasi Pejabat lebih tepat disebut:

> **policy stress-test + civil-risk simulator**

daripada:

> ~~mesin ramal demo~~

Kegunaan utamanya adalah membandingkan kemungkinan konsekuensi dari **respons kebijakan yang berbeda**.

Satu skenario dapat diuji dengan:

```text
baseline
dialog dan respons cepat
klarifikasi komunikasi
review / penundaan kebijakan
respons minimal
stress-test intervensi tinggi
```

Artinya pengguna bisa bertanya:

> “Kalau kebijakannya sama, tetapi respons pemerintah berubah, bagaimana model risiko ikut berubah?”

Itulah salah satu fungsi paling penting proyek ini.

---

# SIMULASI 7 HARI

Menu timeline membuat skenario berkembang selama tujuh hari.

Model dapat membuat drift pada:

- momentum daring;
- perhatian media;
- koalisi;
- dukungan publik;
- incident shock;
- grievance;
- trigger.

Simulasi menggunakan **deterministic seed**.

Input sama + seed sama = hasil simulasi yang sama.

Jadi skenario dapat:

- direproduksi;
- dibandingkan;
- diaudit;
- diuji ulang oleh orang lain.

> Timeline ini adalah **scenario simulation**, bukan ramalan berita masa depan.

---

# MENU

```text
[1]  Simulasi cepat (guided)
[2]  Edit semua variabel (advanced)
[3]  Jalankan skenario aktif
[4]  Simulasikan 7 hari ke depan
[5]  Bandingkan respons kebijakan
[6]  Simpan skenario
[7]  Muat skenario
[8]  Lihat audit log lokal
[9]  Metodologi / hukum / referensi
[10] Evaluasi model dari CSV historis
[11] Muat skenario contoh
[12] Export hasil aktif ke JSON
[0]  Keluar
```

Mode `[1]` dibuat agar orang yang tidak mengenal Prolog tetap bisa menggunakan simulator.

Mode `[2]` membuka variabel yang lebih lengkap untuk pengguna riset.

---

# VARIABEL YANG DIMODELKAN

Beberapa input utama:

```text
grievance
trigger
salience
online momentum
coalition
organization
economic stress
institutional distrust
incident shock
recent precedent
media attention
public support
regional relevance
government communication
government responsiveness
organizer control
intervention pressure
duration
population
evidence quality
```

Semua input utama berada di **tingkat agregat**.

---

# EXPLAINABLE. BUKAN BLACK BOX.

Bobot model dapat dibaca langsung di source:

```text
prolog/ap_model.pl
```

Contoh bobot likelihood v0.1.0.0:

| Faktor | Bobot |
|---|---:|
| grievance | 14% |
| trigger | 13% |
| salience | 10% |
| online momentum | 8% |
| coalition | 8% |
| institutional distrust | 8% |
| incident shock | 8% |
| organization | 7% |
| economic stress | 7% |
| media attention | 5% |
| public support | 5% |
| recent precedent | 4% |
| regional relevance | 3% |

Faktor mitigasi:

| Faktor | Efek |
|---|---:|
| government responsiveness | -8% |
| government communication | -6% |

Tidak ada bobot tersembunyi di layanan cloud.

Tidak ada model proprietary.

Tidak ada “trust the algorithm”.

> Semua orang boleh membuka source, mengkritik bobotnya, menguji ulang, dan membuat model pembanding.

---

# PENTING: 76/100 ≠ PROBABILITAS 76%

v0.1.0.0 adalah **weighted heuristic**.

Jadi:

```text
likelihood = 76
```

berarti:

> **risk index 76/100 berdasarkan model saat ini**

bukan:

> **76% pasti terjadi demonstrasi**

Model belum mengklaim:

- probabilitas empiris terkalibrasi;
- hubungan kausal;
- akurasi forecasting tertentu;
- kemampuan mengetahui masa depan.

Confidence juga sengaja dibatasi.

```text
maksimum confidence v0.1 = 68
```

Karena angka yang terlihat rapi tidak boleh otomatis terlihat pasti.

---

# SIAPA YANG BISA PAKE?

### 🏛 Analis kebijakan

Untuk melakukan stress-test sebelum keputusan besar diumumkan.

### 🎓 Mahasiswa & peneliti

Untuk:

- scenario modelling;
- civil-unrest forecasting research;
- explainable modelling;
- calibration experiments;
- baseline penelitian.

### 📰 Jurnalis / data analyst

Untuk menyusun skenario secara lebih sistematis daripada hanya memakai intuisi.

### 🤝 NGO / civil society

Untuk memisahkan:

- dukungan terhadap tuntutan;
- mobilisasi;
- penyebaran;
- tekanan politik;
- risiko eskalasi.

### 📢 Public affairs / komunikasi

Untuk menguji dampak hipotetis dari:

- komunikasi buruk;
- respons lambat;
- klarifikasi;
- dialog;
- review kebijakan.

### 🧠 Pengajar

Untuk menjelaskan perbedaan:

```text
risk score
probability
confidence
calibration
causality
scenario simulation
```

### 💻 Developer Prolog

Sebagai contoh aplikasi SWI-Prolog dengan:

- pack application;
- modular architecture;
- terminal UI;
- JSON export;
- persistence;
- deterministic simulation;
- PL-Unit;
- audit tooling.

---

# PRINSIP KERAS

Nama proyeknya satir.

Batasannya tidak.

**Antisipasi Pejabat bukan alat pengawasan individu.**

Project inti tidak menyediakan:

- database nama aktivis;
- nomor telepon;
- akun pribadi;
- face recognition;
- alamat rumah;
- profiling mahasiswa;
- profiling serikat;
- scoring risiko individu;
- identifikasi pemimpin aksi;
- prediksi siapa yang harus ditangkap;
- rekomendasi pembubaran;
- pengejaran;
- infiltrasi;
- sabotase mobilisasi;
- optimasi lokasi/timing penindakan.

Hak demonstrasi dan kritik kebijakan **bukan bug yang harus diperbaiki**.

Output diarahkan untuk:

```text
mitigasi
dialog
komunikasi
evaluasi kebijakan
riset
```

bukan represi.

Baca:

```text
docs/ETIKA_DAN_BATASAN.md
```

---

# CASEBOOK INDONESIA

Desain model menggunakan casebook demonstrasi Indonesia sejak 2019 untuk membantu menentukan **struktur variabel**.

Casebook digunakan untuk memahami pola seperti:

```text
grievance yang menumpuk
immediate trigger
coalition
geographic spread
incident shock
narrative drift
policy response
```

Casebook:

> **bukan training dataset**

dan tidak digunakan untuk memberi stigma permanen kepada:

- provinsi;
- kampus;
- profesi;
- serikat;
- komunitas tertentu.

Baca:

```text
docs/KASUS_INDONESIA.md
```

---

# EVALUASI MODEL

Antisipasi Pejabat memiliki evaluation harness CSV.

```bash
swipl antisipasipejabat evaluate dataset.csv
```

Saat ini tersedia:

```text
accuracy
Brier score
jumlah event
```

Dataset contoh:

```text
examples/historical_synthetic.csv
```

bersifat **sintetis** dan hanya digunakan untuk mengetes pipeline.

Untuk penelitian serius, gunakan dataset historis sendiri dan hindari data leakage.

---

# SAVE / LOAD / JSON

Skenario dapat disimpan sebagai:

```text
.ap.pl
```

dan dimuat kembali.

Loader membaca file sebagai **data term**, bukan menjalankannya sebagai program.

Hasil simulasi dapat diekspor sebagai:

```text
.json
```

sehingga dapat dipakai oleh:

- dashboard;
- aplikasi web;
- pipeline analisis;
- notebook;
- sistem lain.

---

# AUDIT

Simulasi interaktif dapat membuat audit log lokal:

```text
~/.antisipasipejabat/audit.log
```

Yang disimpan hanya:

```text
timestamp
scenario hash
likelihood
spread
escalation
confidence
```

Tidak menyimpan nama orang atau isi lengkap skenario.

Build tooling juga menyediakan:

```bash
python3 tools/run_all_audits.py
```

Audit mencakup:

- static source checks;
- module/dependency graph;
- release integrity;
- mathematical mirror sanity.

Mathematical mirror menguji **25.000 skenario acak** untuk mengecek bounds dan sanity dasar formula.

---

# TEST

```bash
swipl -p library=prolog -q -s test/run_tests.pl
```

Regression/unit test mencakup:

```text
score bounds
monotonic sanity
confidence cap
crowd bucket
legal-note regression
save/load roundtrip
JSON export
deterministic simulation
```

---

# CONTOH SKENARIO

Repository membawa skenario hipotetis:

```text
examples/scenario_bbm.ap.pl
examples/scenario_ukt.ap.pl
examples/scenario_integritas.ap.pl
```

Contoh:

```bash
swipl antisipasipejabat simulate examples/scenario_bbm.ap.pl
```

---

# CLI

```bash
swipl antisipasipejabat --help
swipl antisipasipejabat --version
swipl antisipasipejabat simulate FILE.ap.pl
swipl antisipasipejabat evaluate FILE.csv
```

---

# STRUKTUR

```text
app/
    pack application

prolog/
    model
    CLI
    simulation
    comparison
    calibration
    legal notes
    audit
    I/O

data/
    katalog isu
    provinsi

examples/
    skenario hipotetis
    CSV sintetis

test/
    PL-Unit regression tests

docs/
    metodologi
    penggunaan
    casebook Indonesia
    etika
    validasi
    referensi

tools/
    static audit
    dependency audit
    model mirror
    release checks

pack.pl
    metadata SWI-Prolog Pack
```

---

# STATUS v0.1.0.0

✅ Published on SWI-Prolog Pack Registry  
✅ Installable menggunakan `swipl pack install antisipasipejabat`  
✅ Full terminal interface  
✅ Explainable weighted model  
✅ Counterfactual policy response  
✅ Deterministic 7-day simulation  
✅ Save / load scenario  
✅ JSON export  
✅ Audit log lokal  
✅ Historical evaluation harness  
✅ PL-Unit regression tests  
✅ Static audit tooling  
✅ CC0 1.0 Universal  

Namun:

⚠️ belum merupakan calibrated forecasting model  
⚠️ belum merupakan causal model  
⚠️ tidak menggunakan live data otomatis  
⚠️ tidak menjanjikan akurasi kejadian masa depan  

---

# ROADMAP

Target penelitian berikutnya:

```text
event-level Indonesian dataset
temporal train/validation/test split
probability calibration
calibration curve
Brier decomposition
logistic regression baseline
ablation study
out-of-sample evaluation
regional/time error audit
data provenance
model card
```

Tujuan akhirnya bukan membuat skor terlihat semakin menyeramkan.

Tujuannya adalah membuat skor **semakin dapat dipertanggungjawabkan**.

---

# DOKUMENTASI

Baca sebelum penggunaan serius:

- [`docs/CARA_PAKAI.md`](docs/CARA_PAKAI.md)
- [`docs/METODOLOGI.md`](docs/METODOLOGI.md)
- [`docs/KASUS_INDONESIA.md`](docs/KASUS_INDONESIA.md)
- [`docs/VALIDATION_REPORT.md`](docs/VALIDATION_REPORT.md)
- [`docs/ETIKA_DAN_BATASAN.md`](docs/ETIKA_DAN_BATASAN.md)
- [`docs/AUDIT.md`](docs/AUDIT.md)
- [`docs/REFERENSI.md`](docs/REFERENSI.md)

---

# LICENSE

**CC0 1.0 Universal (`CC0-1.0`)**

Proyek ini didedikasikan ke domain publik sejauh diizinkan hukum.

Lihat [`LICENSE`](LICENSE).

---

# AUTHOR

**Aires Zam Wibisono**

Repository:

```text
https://github.com/kocoygroup-id/antisipasipejabat
```

Install:

```bash
swipl pack install antisipasipejabat
```

---

# TL;DR

```text
Bukan alat buat mencari demonstran.
Bukan alat buat membubarkan demonstrasi.

Ini alat buat bertanya:

“Kalau kebijakan ini dijalankan,
apa konsekuensi publik yang seharusnya sudah kita pikirkan?”
```

## **Antisipasi kebijakannya. Bukan rakyatnya.**
