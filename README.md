# Antisipasi Pejabat v0.1.0.0 💀

**Indonesian Civil Demonstration Risk Simulator — full SWI-Prolog, full terminal.**

Antisipasi Pejabat adalah simulator skenario untuk menguji bagaimana kombinasi tekanan ekonomi, akumulasi keluhan, pemicu kebijakan, momentum daring, koalisi, dukungan publik, respons pemerintah, dan insiden tambahan *mungkin* berhubungan dengan risiko demonstrasi, penyebaran, dan eskalasi.

Nama sengaja satir. Modelnya tidak bercanda soal metodologi: setiap skor dapat dijelaskan, semua input berada di tingkat agregat, confidence dibatasi, dan v0.1.0.0 **tidak mengklaim sudah terkalibrasi secara empiris**.

## Prinsip keras

- Hak demonstrasi dan kritik kebijakan bukan musuh yang harus "dimatikan".
- Tidak ada database nama aktivis, nomor telepon, akun pribadi, wajah, alamat rumah, atau profiling individu.
- Tidak ada rekomendasi taktik pembubaran, pengejaran, penangkapan, pengawasan, atau sabotase mobilisasi.
- Output adalah *policy-impact / civil-risk simulation* untuk mitigasi, dialog, komunikasi, dan evaluasi kebijakan.
- Model membedakan **likelihood**, **spread**, **escalation**, **political pressure**, dan **confidence**.

## Instalasi

Butuh **SWI-Prolog 9.1.18+** agar pack application dapat dipanggil dengan `swipl antisipasipejabat`.

Dari folder hasil ekstrak:

```text
swipl pack install .
swipl antisipasipejabat
```

Setelah paket dipublikasikan di SWI-Prolog Pack Registry, bentuk resminya:

```text
swipl pack install antisipasipejabat
swipl antisipasipejabat
```

> `swipl install antisipasipejabat` bukan sintaks stock SWI-Prolog. Bentuk resmi adalah `swipl pack install ...`.

## Menu orang awam

```text
[1] Simulasi cepat (guided)
[2] Edit semua variabel (advanced)
[3] Jalankan skenario aktif
[4] Simulasikan 7 hari ke depan
[5] Bandingkan respons kebijakan
[6] Simpan skenario
[7] Muat skenario
[8] Lihat audit log lokal
[9] Metodologi / hukum / referensi
[10] Evaluasi model dari CSV historis
[11] Muat skenario contoh
[12] Export hasil aktif ke JSON
[0] Keluar
```

Tidak perlu menulis query Prolog untuk penggunaan normal.

## CLI

```text
swipl antisipasipejabat --help
swipl antisipasipejabat --version
swipl antisipasipejabat simulate examples/scenario_bbm.ap.pl
swipl antisipasipejabat evaluate examples/historical_synthetic.csv
```

## Output inti

- Risiko kemungkinan aksi 0–100
- Potensi penyebaran 0–100
- Risiko eskalasi 0–100
- Tekanan kebijakan 0–100
- Kemungkinan kelanjutan
- State indikatif berbasis terminologi demonstrasi ACLED
- Bucket turnout: very small / small / medium / large / massive
- Faktor pendorong utama dan faktor mitigasi
- Confidence yang sengaja dibatasi pada model heuristik
- Catatan hukum ringkas

## Struktur

```text
app/                         pack-app: swipl antisipasipejabat
prolog/                      engine, CLI, model, audit, legal, I/O
data/                        katalog provinsi dan isu
examples/                    skenario hipotetis + CSV sintetis
test/                        regression/unit tests
docs/                        dokumentasi Indonesia lengkap
tools/                       static audit + release checker
pack.pl                      metadata SWI-Prolog pack
```

Baca `docs/CARA_PAKAI.md`, `docs/METODOLOGI.md`, `docs/KASUS_INDONESIA.md`, `docs/VALIDATION_REPORT.md`, `docs/ETIKA_DAN_BATASAN.md`, dan `docs/REFERENSI.md` sebelum menggunakan output untuk keputusan nyata.
## Lisensi

Proyek ini didedikasikan ke domain publik sejauh diizinkan hukum melalui **CC0 1.0 Universal** (`CC0-1.0`). Lihat `LICENSE` untuk teks legal lengkap.

