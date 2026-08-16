# Security

Antisipasi Pejabat tidak membuka port jaringan dan tidak membutuhkan service daemon.

Laporkan bug yang menyebabkan file arbitrer dieksekusi, path traversal, atau kebocoran isi skenario. Loader skenario membaca term sebagai data dan menolak term non-dict; ia tidak melakukan `consult/1` pada file pengguna.

Jangan tambahkan fungsi pengumpulan identitas individu, credential, atau lokasi pribadi ke core project.
