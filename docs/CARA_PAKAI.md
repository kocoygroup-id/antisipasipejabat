# Cara Pakai — dari orang awam sampai peneliti

## 1. Jalankan

```text
swipl antisipasipejabat
```

Pilih menu dengan angka. Untuk pengguna non-IT, mulai dari **[1] Simulasi cepat**.

## 2. Arti input cepat

Selain nama, skala, jenis isu, target tuntutan, provinsi/kota, dan sub-isu, mode cepat meminta indeks berikut:

1. **Akumulasi keluhan** — seberapa besar rasa tidak puas yang sudah ada sebelum pemicu terbaru.
2. **Kekuatan pemicu** — seberapa kuat kebijakan/kejadian baru menjadi alasan orang bergerak.
3. **Salience/kepentingan isu** — seberapa penting isu tersebut bagi publik yang relevan.
4. **Dukungan publik** — dukungan pada *substansi tuntutan*, bukan persetujuan atas setiap metode aksi.
5. **Momentum daring** — seberapa cepat isu tersebar dan bertahan dalam percakapan publik digital.
6. **Responsivitas/dialog pemerintah** — seberapa cepat ada respons substantif, bukan sekadar banyaknya konferensi pers.
7. **Kualitas bukti input** — keyakinan bahwa angka yang dimasukkan memang berbasis data/sumber, bukan feeling.

Gunakan 0 = sangat rendah, 50 = sedang/tidak yakin, 100 = sangat tinggi.

## 3. Advanced

Menu advanced menambahkan koalisi, organisasi, tekanan ekonomi, distrust, shock insiden, preseden, media, relevansi wilayah, komunikasi, kontrol penyelenggara, intervention pressure, durasi, populasi, dan status pemberitahuan, serta seed untuk reproduksibilitas.

**Intervention pressure** adalah variabel analitis untuk menguji korelasi eskalasi. Ia bukan tombol "seberapa keras harus membubarkan".

## 4. Membaca hasil

Jangan baca `likelihood=75` sebagai "75% pasti demo". Pada v0.1.0.0 angka 75 berarti **indeks risiko 75/100 berdasarkan bobot heuristik**.

`confidence` juga bukan confidence interval statistik. Ia menunjukkan kualitas input yang diperkirakan dan sengaja dibatasi maksimum 68 selama model belum dikalibrasi.

## 5. Timeline 7 hari

Timeline memakai seed deterministik. Input sama + seed sama menghasilkan drift yang sama. Drift hanya mensimulasikan perubahan ringan pada momentum daring, media, koalisi, dukungan, dan decay shock; ia tidak memprediksi berita nyata.

## 6. Perbandingan respons

Menu perbandingan menjalankan beberapa counterfactual sederhana:

- baseline
- dialog/respons cepat
- klarifikasi komunikasi
- review/penundaan kebijakan
- respons minimal
- stress-test intervensi tinggi

Skenario intervensi tinggi ada untuk melihat **risikonya**, bukan rekomendasi.

## 7. Simpan / muat

Skenario tersimpan sebagai term data `.ap.pl`. Loader hanya membaca satu term dict dan tidak menjalankan isi file sebagai program.

## 8. Evaluasi CSV historis

`evaluate` menghitung accuracy threshold 50 dan Brier score. Contoh CSV yang disediakan **sintetis**, hanya untuk mengecek pipeline.

Untuk riset yang benar, buat data historis sendiri dengan definisi fitur yang konsisten dan tentukan fitur tanpa mengintip outcome.


## 9. Skenario contoh dan export JSON

Menu **[11]** memuat tiga skenario hipotetis bawaan (BBM, UKT, integritas). Menu **[12]** mengekspor ringkasan hasil aktif ke JSON. Komponen internal `contributions` yang memakai term Prolog tidak ikut diekspor agar JSON tetap interoperabel.

Skenario contoh diselesaikan relatif terhadap lokasi pack, jadi menu tetap bekerja walau `swipl antisipasipejabat` dijalankan dari direktori lain.
