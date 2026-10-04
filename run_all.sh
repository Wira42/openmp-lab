#!/usr/bin/env bash
# Build and run all OpenMP lab exercises (1-8). Usage: ./run_all.sh 2>&1 | tee hasil_run.txt
set -e
cd "$(dirname "$0")"

export OMP_DYNAMIC=FALSE

echo "=== Environment ==="
grep PRETTY_NAME /etc/os-release
gcc --version | head -n 1
echo "nproc: $(nproc)"
lscpu | grep -E "Model name|^CPU\(s\)" || true

echo
echo "=== Build ==="
make -s clean
make -s all

for t in 1 2 4; do
  echo; echo "=== Exercise 1, OMP_NUM_THREADS=$t ==="
  OMP_NUM_THREADS=$t ./ex1_hello_openmp
done

echo; echo "=== Exercise 2, OMP_NUM_THREADS=4 ==="
OMP_NUM_THREADS=4 ./ex2_data_sharing

for t in 1 2 4; do
  echo; echo "=== Exercise 3, OMP_NUM_THREADS=$t ==="
  OMP_NUM_THREADS=$t ./ex3_vector_add
done

for t in 1 2 4; do
  echo; echo "=== Exercise 4, OMP_NUM_THREADS=$t ==="
  OMP_NUM_THREADS=$t ./ex4_sum_methods
done

for s in static "static,1" "dynamic,1" "guided,1"; do
  echo; echo "=== Exercise 5, OMP_SCHEDULE=$s, OMP_NUM_THREADS=4 ==="
  OMP_SCHEDULE="$s" OMP_NUM_THREADS=4 ./ex5_schedules
done

echo; echo "=== Exercise 6, OMP_NUM_THREADS=4 ==="
OMP_NUM_THREADS=4 ./ex6_phases

echo; echo "=== Exercise 7, OMP_NUM_THREADS=4 ==="
OMP_NUM_THREADS=4 ./ex7_tasks

for t in 1 2; do
  echo; echo "=== Exercise 8, OMP_NUM_THREADS=$t ==="
  OMP_NUM_THREADS=$t ./ex8_pi_benchmark
done
