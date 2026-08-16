# Catatan kasus Indonesia untuk desain model

Dokumen ini adalah **casebook desain**, bukan dataset training dan bukan dasar untuk memberi label pada kelompok/daerah tertentu. Kasus dipakai untuk memeriksa apakah variabel simulator mampu merepresentasikan pola nyata seperti *trigger*, grievance yang sudah menumpuk, koalisi lintas kelompok, penyebaran antarkota, perubahan tuntutan, respons kebijakan, dan eskalasi setelah insiden.

## 2019 — mahasiswa, KPK, dan perubahan hukum

Reuters melaporkan gelombang demonstrasi mahasiswa pada September 2019 terkait perubahan pada lembaga antikorupsi dan rancangan hukum pidana. Ini mendukung pemisahan antara `grievance` (kekhawatiran lebih luas tentang kualitas reformasi/demokrasi), `trigger` (perubahan kebijakan/hukum), `salience`, dan `organization`.

Sumber:
- https://www.reuters.com/article/world/anger-on-campus-behind-the-student-protests-that-have-rocked-indonesia-idUSKBN1XH2XF/
- https://www.reuters.com/article/world/indonesia-student-protests-against-law-changes-enter-third-day-idUSKBN1WA0PZ/

## 2020 — Omnibus / Jobs Law

Aksi menentang Jobs Creation Law melibatkan mahasiswa dan pekerja serta muncul di banyak wilayah. Kasus ini penting untuk `coalition`, `organization`, `regional_relevance`, dan `spread`. Ia juga menunjukkan bahwa event protest dan respons/intervensi perlu dicatat sebagai dimensi berbeda.

Sumber:
- https://www.reuters.com/world/asia-pacific/thousands-join-protest-against-indonesia-jobs-law-2020-10-20/
- https://www.reuters.com/world/protests-indonesia-against-new-jobs-law-enter-third-day-2020-10-08/
- https://www.reuters.com/markets/us/indonesia-parliament-passes-flagship-jobs-bill-critics-vow-protests-2020-10-05/

## 2022 — kenaikan harga BBM

Pemerintah menaikkan harga BBM bersubsidi sekitar 30%; aksi pekerja dan mahasiswa menyusul di berbagai wilayah. Pemerintah kemudian menyatakan akan meninjau aturan upah minimum dan ketenagakerjaan. Kasus ini memperlihatkan pentingnya `economic_stress`, `trigger`, `public_support`, dan *policy response* sebagai variabel yang dapat berubah setelah aksi berlangsung.

Sumber:
- https://www.reuters.com/world/asia-pacific/indonesia-hikes-fuel-prices-rein-ballooning-subsidies-2022-09-03/
- https://www.reuters.com/world/asia-pacific/indonesia-review-minimum-wage-rules-after-protests-over-fuel-price-hike-2022-09-13/

## 2024 — polemik aturan Pilkada

Aksi lintas kota muncul setelah manuver parlemen terkait aturan pemilihan daerah yang berseberangan dengan putusan Mahkamah Konstitusi. Parlemen menunda perubahan, dan regulasi berikutnya diselaraskan dengan putusan MK. Kasus ini menjadi alasan output kebijakan tidak dibuat biner “menang/kalah”, melainkan dapat berupa *delay*, review, konsesi sebagian, atau proses kelembagaan.

Sumber:
- https://www.reuters.com/world/asia-pacific/power-struggle-between-indonesias-court-parliament-sparks-protests-2024-08-22/
- https://www.reuters.com/world/asia-pacific/protesters-rally-again-indonesia-tempers-flare-over-political-manoeuvres-2024-08-23/
- https://www.reuters.com/world/asia-pacific/indonesia-election-body-gets-approval-issue-new-rules-line-with-protesters-2024-08-25/

## Februari 2025 — “Indonesia Gelap”

Reuters mencatat aksi mahasiswa di berbagai kota terkait pemotongan anggaran dan kebijakan lain. ACLED menyebut sekitar 100 demonstrasi mahasiswa di sedikitnya 30 provinsi selama Februari. Ini mendukung adanya `online`, `regional_relevance`, `media_attention`, serta pembedaan event nasional dari satu kerumunan tunggal.

Sumber:
- https://www.reuters.com/world/asia-pacific/students-lead-dark-indonesia-protests-against-budget-cuts-2025-02-20/
- https://www.reuters.com/world/asia-pacific/protesters-extend-dark-indonesia-rally-against-prabowos-policies-2025-02-21/
- https://acleddata.com/update/asia-pacific-overview-march-2025

## Agustus–September 2025 — trigger berubah dan tuntutan melebar

Reuters menggambarkan protes yang awalnya dipicu kemarahan terhadap tunjangan anggota parlemen, lalu membesar setelah kematian seorang pengemudi ojol dalam rangkaian aksi. Gerakan menyebar ke banyak provinsi dan membawa keluhan lebih luas. Ini mendukung pemisahan `trigger`, `incident_shock`, `grievance`, `spread`, dan *narrative drift*. Pemerintah juga mengumumkan pengurangan sejumlah fasilitas anggota parlemen, sehingga `govt_responsiveness` relevan sebagai faktor dinamis.

Sumber:
- https://www.reuters.com/world/asia-pacific/indonesia-accepts-protesters-demand-cut-lawmakers-perks-amid-unrest-2025-08-31/
- https://www.reuters.com/world/asia-pacific/whats-fuelling-rage-indonesia-2025-09-02/

## Juni 2026 — kebijakan ekonomi dan program nasional

ACLED melaporkan lebih dari 150 demonstrasi sepanjang Juni yang berkaitan dengan kebijakan ekonomi, khususnya program MBG. Reuters pada 12 Juni 2026 melaporkan aksi mahasiswa di Jakarta mengenai prioritas belanja, kenaikan harga bensin, dan isu peran militer di ranah sipil. Ini menegaskan bahwa satu periode dapat memiliki **multi-issue grievance** dan bahwa `issue` hanyalah kategori utama, bukan klaim bahwa semua peserta memiliki alasan identik.

Sumber:
- https://acleddata.com/update/asia-pacific-overview-july-2026
- https://www.reuters.com/world/asia-pacific/students-hold-heading-bankrupt-indonesia-protests-against-prabowos-policies-2026-06-12/

## Pelajaran yang masuk ke v0.1

1. Pisahkan keluhan struktural dan pemicu langsung.
2. Ukur penyebaran terpisah dari peluang terjadinya aksi.
3. Insiden tambahan dapat mengubah lintasan sehingga punya field sendiri.
4. Koalisi mahasiswa, pekerja, profesi, dan masyarakat tidak boleh diperlakukan identik.
5. Outcome kebijakan bukan sekadar diterima/ditolak.
6. Crowd size lebih jujur dalam bucket daripada angka presisi palsu.
7. “Aksi damai”, “aksi dengan intervensi”, dan “violent demonstration” bukan sinonim.
8. Variabel harus bersifat agregat; casebook ini tidak menyimpan daftar individu, akun, jaringan, rute, atau titik kumpul.

## Yang sengaja TIDAK dilakukan

Kasus di atas **tidak** dipakai untuk menetapkan bahwa provinsi, kampus, serikat, profesi, atau komunitas tertentu “rawan”. v0.1 juga tidak mengestimasi siapa yang harus dipantau, siapa pemimpin gerakan, titik mana yang harus diblokir, atau bagaimana aksi dapat digagalkan.
