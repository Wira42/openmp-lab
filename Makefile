CC     = gcc
CFLAGS = -std=c11 -O2 -Wall -Wextra -fopenmp
BINS   = ex1_hello_openmp ex2_data_sharing ex3_vector_add ex4_sum_methods \
         ex5_schedules ex6_phases ex7_tasks ex8_pi_benchmark

all: $(BINS)

ex8_pi_benchmark: ex8_pi_benchmark.c
	$(CC) $(CFLAGS) $< -o $@ -lm

%: %.c
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f $(BINS)

.PHONY: all clean
