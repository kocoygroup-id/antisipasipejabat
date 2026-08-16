# Format Skenario

Skenario adalah SWI-Prolog dict dengan tag `scenario`.

Contoh minimal yang disarankan:

```text
scenario{
  name:"Uji kebijakan X",
  scope:provinsi,
  province:"Jawa Barat",
  city:"Bandung",
  issue:kebijakan_publik,
  subissue:"kebijakan X hipotetis",
  target:pemerintah_daerah,
  grievance:60,
  trigger:70,
  public_support:65,
  online:55,
  govt_responsiveness:45,
  evidence_quality:50
}.
```

Field yang tidak ada akan diisi default oleh engine ketika dict diberikan lewat API. File hasil menu Simpan menyimpan seluruh field agar reproducible.

Semua indeks utama 0–100. `duration_days` 1–365, `population_millions` 0.01–300, `seed` integer.
