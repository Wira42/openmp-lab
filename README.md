# OpenMP Lab: Exercise 1-8 (C, Linux, GCC)

Kumpulan kode untuk tutorial *OpenMP Programming: A Practical Tutorial in C*.

## Isi

| File | Exercise | Topik |
|---|---|---|
| `ex1_hello_openmp.c` | 1 | Tim thread, parallel region |
| `ex2_data_sharing.c` | 2 | shared, private, firstprivate, default(none) |
| `ex3_vector_add.c` | 3 | Paralelisasi loop (parallel for) |
| `ex4_sum_methods.c` | 4 | Reduction vs atomic vs critical |
| `ex5_schedules.c` | 5 | Loop schedule (OMP_SCHEDULE) |
| `ex6_phases.c` | 6 | Barrier, single, fase bergantung |
| `ex7_tasks.c` | 7 | Task dan taskwait |
| `ex8_pi_benchmark.c` | 8 | Benchmark pi, speedup, efisiensi |
| `Makefile` | | Build semua program |
| `run_all.sh` | | Build + jalankan semua, cetak info lingkungan |
| `hasil_run.txt` | | Contoh log hasil run (lihat catatan) |

## Cara reproduksi

Kebutuhan: Ubuntu/Debian dengan `build-essential` (GCC).

```bash
sudo apt update && sudo apt install build-essential
make                                   # atau: make clean && make
./run_all.sh 2>&1 | tee hasil_run.txt  # build + jalankan semua
```

Flag kompilasi yang dipakai: `gcc -std=c11 -O2 -Wall -Wextra -fopenmp` (Exercise 8 ditambah `-lm`).

Menjalankan satu program, contoh:

```bash
export OMP_DYNAMIC=FALSE
OMP_NUM_THREADS=4 ./ex1_hello_openmp
OMP_SCHEDULE="dynamic,1" OMP_NUM_THREADS=4 ./ex5_schedules
```

Ukuran benchmark Exercise 8 bisa diubah saat kompilasi:

```bash
gcc -std=c11 -O2 -Wall -Wextra -fopenmp -DNUM_STEPS=200000000LL ex8_pi_benchmark.c -o ex8_pi_benchmark -lm
```

## Hasil yang diharapkan

- Exercise 1, 2, 7: urutan baris output bervariasi antar-run (penjadwalan thread tidak deterministik).
- Exercise 3: `c[0]=0.0 c[n-1]=2999997.0 errors=0` untuk semua jumlah thread.
- Exercise 4: keempat nilai bernilai 500000500000.
- Exercise 6: `mean=6.5 first=-5.5 last=5.5 sum=0.0`.
- Exercise 8: `difference` sangat kecil (di bawah 1e-8); waktu dan speedup bergantung mesin.

## Catatan

- `hasil_run.txt` dihasilkan di mesin pembuat repositori ini. **Jalankan ulang `./run_all.sh` di mesin Anda** dan ganti file tersebut dengan log Anda sendiri; spesifikasi CPU, versi GCC, dan angka waktu akan berbeda.
- Pada mesin dengan 2 CPU logis, menjalankan 4 thread berarti oversubscription. Itu tidak masalah untuk memeriksa kebenaran (Exercise 1-7), tetapi untuk benchmark Exercise 8 gunakan 1 dan 2 thread.
- Exercise 1 pada repositori ini adalah versi tutorial murni. Jika Anda memakai versi modifikasi (tambahan `printf`), sebutkan di laporan.
