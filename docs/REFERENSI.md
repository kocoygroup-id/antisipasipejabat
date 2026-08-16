# Referensi dan sumber metodologi

Dokumen ini memisahkan **sumber definisi**, **sumber data Indonesia**, dan **literatur forecasting**. Tidak semua referensi menjadi koefisien langsung; bobot v0.1 tetap heuristik dan dapat diaudit di source.

## SWI-Prolog / packaging

1. SWI-Prolog — Installing packs: https://www.swi-prolog.org/pldoc/man?section=pack-install
2. SWI-Prolog — `pack_install/1`: https://www.swi-prolog.org/pldoc/man?predicate=pack_install%2F1
3. SWI-Prolog — Developing a pack: https://www.swi-prolog.org/pldoc/man?section=pack-devel
4. SWI-Prolog — app scripts / `swipl <app>`: https://www.swi-prolog.org/pldoc/man?section=swipl-app
5. SWI-Prolog — command line: https://www.swi-prolog.org/pldoc/man?section=cmdline

## Definisi demonstration event

6. ACLED Codebook: https://acleddata.com/methodology/acled-codebook
7. ACLED Methodology Knowledge Base: https://acleddata.com/conflict-data/knowledge-base/methodology
8. ACLED Crowd Size Methodology (updated July 2026): https://acleddata.com/methodology/how-crowd-size-protests-and-riots-coded-acled-data
9. ACLED Asia-Pacific Overview, August 2024: https://acleddata.com/update/asia-pacific-overview-august-2024
10. ACLED Asia-Pacific Overview, March 2025: https://acleddata.com/update/asia-pacific-overview-march-2025

## Hukum dan data resmi Indonesia

11. UU RI No. 9 Tahun 1998, Kemerdekaan Menyampaikan Pendapat di Muka Umum — BPK: https://peraturan.bpk.go.id/Details/45478
12. Mahkamah Konstitusi, Putusan/ikhtisar Perkara 271/PUU-XXIII/2025 dan pemberitaan resmi 2 Maret 2026 mengenai Pasal 256 KUHP: https://mkri.id/berita/penyampaian-pendapat-di-muka-umum-tanpa-pemberitahuan%2C-akan-kena-sanksi-pidana-jika-ganggu-kepentingan-umum-24705
13. Ikhtisar Putusan 271/PUU-XXIII/2025: https://s.mkri.id/public/content/persidangan/sinopsis/ikhtisar_4829_2927_%5B8%5D%20Ikhtisar%20-%20271%20PUU%202025%20%28ACC%20PM%20III%29.pdf
14. BPS WebAPI: https://webapi.bps.go.id/developer
15. Pelayanan Statistik Terpadu BPS: https://pst.bps.go.id/
16. data.go.id — Jumlah Unjuk Rasa / Demonstrasi Kabupaten Temanggung 2018–2026: https://data.go.id/dataset/dataset/jumlah-unjuk-rasa-demonstrasi
17. data.go.id — Demonstrasi/Unjuk Rasa Kep. Bangka Belitung: https://data.go.id/dataset/dataset/demonstrasi-unjuk-rasa
18. data.go.id — Data Kasus Unjuk Rasa Kabupaten Mukomuko 2025: https://data.go.id/dataset/dataset/data-kasus-unjuk-rasa-di-kabupaten-mukomuko-tahun-2025
19. data.go.id — Demonstrasi Kabupaten Bantul 2016–2020: https://data.go.id/dataset/dataset/demonstrasi-di-kabupaten-bantul
20. data.go.id — Demonstrasi Kabupaten Deli Serdang 2022–2024: https://data.go.id/dataset/dataset/jumlah-demonstrasi-di-kabupaten-deli-serdang-tahun-2022-2024

## Forecasting / early warning

21. Hlatshwayo & Redl, *Forecasting Social Unrest: A Machine Learning Approach*, IMF Working Paper 2021/263: https://www.elibrary.imf.org/view/journals/001/2021/263/article-A001-en.xml
22. Korkmaz et al., *Multi-Source Models for Civil Unrest Forecasting* (2016), open full text: https://pmc.ncbi.nlm.nih.gov/articles/PMC6192062/
23. Ramakrishnan et al., *Forecasting Civil Unrest using Open Source Indicators* (EMBERS): https://people.cs.vt.edu/naren/papers/kddindg1572-ramakrishnan.pdf
24. Deng & Ning, *A Survey on Societal Event Forecasting with Deep Learning* (2021): https://arxiv.org/abs/2112.06345
25. Tuke et al., *Pachinko Prediction: A Bayesian method for event prediction from social media data* (2018): https://arxiv.org/abs/1809.08427
26. Bahrami et al., *Twitter Reveals: Using Twitter Analytics to Predict Public Protests* (2018): https://arxiv.org/abs/1805.00358
27. Macis et al., *Anomaly detection models for early warning of socio-political unrest* (2024), Technological Forecasting and Social Change.

## Indonesia dan mobilisasi digital

28. ACLED analyses di atas memberi contoh bahwa demonstrasi dapat menyebar lintas wilayah dan bahwa event type harus dipisahkan dari asumsi tentang kekerasan.
29. Literatur tentang mobilisasi digital Indonesia dapat dipakai untuk hipotesis fitur `online`, tetapi v0.1 tidak mengubah engagement media sosial menjadi daftar individu atau target pengawasan.

## Aturan penggunaan referensi

- Periksa tanggal dan versi sumber.
- Jangan menyalin angka hasil penelitian negara lain sebagai koefisien Indonesia tanpa validasi.
- ACLED memiliki terms/conditions untuk data; pengguna yang mengimpor data ACLED wajib mengikuti lisensinya sendiri.
- Data lokal dari data.go.id berbeda cakupan dan definisi; jangan menjumlahkan antardaerah tanpa harmonisasi.

## Casebook historis Indonesia (untuk desain fitur, bukan bobot kausal)

30. Reuters, 2019 student/KPK/criminal-code protests: https://www.reuters.com/article/world/anger-on-campus-behind-the-student-protests-that-have-rocked-indonesia-idUSKBN1XH2XF/
31. Reuters, 25 Sep 2019 student protests: https://www.reuters.com/article/world/indonesia-student-protests-against-law-changes-enter-third-day-idUSKBN1WA0PZ/
32. Reuters, 20 Oct 2020 Jobs Law protests: https://www.reuters.com/world/asia-pacific/thousands-join-protest-against-indonesia-jobs-law-2020-10-20/
33. Reuters, 8 Oct 2020 third day of Jobs Law protests: https://www.reuters.com/world/protests-indonesia-against-new-jobs-law-enter-third-day-2020-10-08/
34. Reuters, 3 Sep 2022 subsidised fuel price rise: https://www.reuters.com/world/asia-pacific/indonesia-hikes-fuel-prices-rein-ballooning-subsidies-2022-09-03/
35. Reuters, 13 Sep 2022 wage-rule review after protests: https://www.reuters.com/world/asia-pacific/indonesia-review-minimum-wage-rules-after-protests-over-fuel-price-hike-2022-09-13/
36. Reuters, 22 Aug 2024 election-law protests: https://www.reuters.com/world/asia-pacific/power-struggle-between-indonesias-court-parliament-sparks-protests-2024-08-22/
37. Reuters, 25 Aug 2024 election-body rules following protests: https://www.reuters.com/world/asia-pacific/indonesia-election-body-gets-approval-issue-new-rules-line-with-protesters-2024-08-25/
38. Reuters, 20 Feb 2025 “Dark Indonesia”: https://www.reuters.com/world/asia-pacific/students-lead-dark-indonesia-protests-against-budget-cuts-2025-02-20/
39. Reuters, 21 Feb 2025 continuation of “Dark Indonesia”: https://www.reuters.com/world/asia-pacific/protesters-extend-dark-indonesia-rally-against-prabowos-policies-2025-02-21/
40. Reuters, 31 Aug 2025 concessions on parliament perks: https://www.reuters.com/world/asia-pacific/indonesia-accepts-protesters-demand-cut-lawmakers-perks-amid-unrest-2025-08-31/
41. Reuters, 2 Sep 2025 explainer on widened grievances and geographic spread: https://www.reuters.com/world/asia-pacific/whats-fuelling-rage-indonesia-2025-09-02/
42. Reuters, 12 Jun 2026 student protest on spending priorities/fuel: https://www.reuters.com/world/asia-pacific/students-hold-heading-bankrupt-indonesia-protests-against-prabowos-policies-2026-06-12/
43. ACLED Asia-Pacific Overview, July 2026: https://acleddata.com/update/asia-pacific-overview-july-2026

Detail interpretasi casebook ada di `docs/KASUS_INDONESIA.md`.
