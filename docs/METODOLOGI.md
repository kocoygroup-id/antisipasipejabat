# Metodologi v0.1.0.0

## Tujuan model

Antisipasi Pejabat memisahkan empat pertanyaan yang sering dicampur:

1. Apakah kondisi agregat mendukung terjadinya aksi?
2. Jika aksi terjadi, apakah isu punya potensi menyebar?
3. Seberapa tinggi risiko eskalasi/intervensi?
4. Seberapa besar tekanan kebijakan yang dihasilkan?

Tidak satu pun skor tersebut dimaksudkan untuk memprediksi perilaku individu.

## Model likelihood

Likelihood adalah weighted heuristic dengan baseline kecil. Faktor positif:

- grievance 14%
- trigger 13%
- salience 10%
- online momentum 8%
- coalition 8%
- organization 7%
- economic stress 7%
- institutional distrust 8%
- incident shock 8%
- recent precedent 4%
- media attention 5%
- public support 5%
- regional relevance 3%

Faktor mitigasi yang dikurangkan:

- kualitas komunikasi pemerintah 6%
- responsivitas/dialog 8%

Bobot sengaja eksplisit di `prolog/ap_model.pl` agar dapat diaudit. Bobot bukan koefisien hasil regresi dan bukan klaim kausal.

## Spread

Spread memberi bobot besar pada momentum daring, relevansi lintas wilayah, koalisi, salience, dukungan publik, media, dan preseden. Scope memberi adjustment kecil.

## Eskalasi

Eskalasi memodelkan grievance, incident shock, intervention pressure, distrust, trigger, durasi, rendahnya organizer control, dan rendahnya responsivitas kebijakan.

Hubungan ini digunakan sebagai **risk stress-test**; tool tidak memberi panduan bagaimana melakukan intervensi.

## Crowd bucket

Output tidak mencoba mengarang angka peserta presisi. Ia memakai lima bucket yang kompatibel dengan metodologi crowd-size ACLED per Juli 2026:

- very small: <20
- small: 20–99
- medium: 100–999
- large: 1.000–9.999
- massive: 10.000+

Antisipasi Pejabat memetakan *turnout index internal* ke bucket tersebut. Itu bukan model BERT ACLED dan tidak boleh disebut sebagai estimasi ACLED.

## State

Terminologi state mengambil inspirasi dari klasifikasi demonstrasi ACLED:

- peaceful protest
- protest with intervention
- excessive force against protesters

Untuk state dengan risiko tinggi, output juga mengingatkan bahwa violent demonstration merupakan klasifikasi berbeda. Simulator hanya memberi **risk label**, tidak menyatakan bahwa kekerasan pasti terjadi.

## Confidence

Karena v0.1 belum memiliki dataset kalibrasi resmi, confidence dibatasi 20–68. Ini mencegah UI menghasilkan kesan kepastian tinggi hanya karena angka input lengkap.

## Evaluasi

`prolog/ap_calibration.pl` menyediakan *evaluation harness* CSV: accuracy dan Brier score. Modul tidak otomatis melatih ulang bobot. Pengguna riset dapat membandingkan model dengan baseline sederhana dan baru mengubah koefisien setelah evaluasi out-of-sample.

## Keterbatasan

- Heuristik, bukan model kausal.
- Tidak memakai data real-time otomatis.
- Tidak memakai demografi sensitif.
- Tidak mengestimasi rute, titik kumpul, jaringan individu, atau identitas penyelenggara.
- Peristiwa politik memiliki non-stationarity; hubungan masa lalu dapat berubah.
- Laporan media dan crowd size dapat bias/ambigu.
- Variabel yang saling berkorelasi dapat membuat skor tampak lebih tegas daripada realitas.

## Rekomendasi riset v0.2

1. Dataset event-level 2019+ dengan label demonstrasi yang konsisten.
2. Split temporal train/validation/test, bukan random split saja.
3. Calibration curve dan Brier decomposition.
4. Baseline model (prevalence-only dan logistic regression) sebagai pembanding.
5. Ablation study tiap kelompok fitur.
6. Fairness/error audit lintas wilayah tanpa membuat "provinsi rawan" sebagai stigma permanen.
7. Data provenance dan versioning.
8. Model card setiap release.
