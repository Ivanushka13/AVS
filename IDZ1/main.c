#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int64_t timespecDiff(
    struct timespec timeA,
    struct timespec timeB
) {
  int64_t nsecA, nsecB;

  nsecA = timeA.tv_sec;
  nsecA *= 1000000000;
  nsecA += timeA.tv_nsec;

  nsecB = timeB.tv_sec;
  nsecB *= 1000000000;
  nsecB += timeB.tv_nsec;

  return nsecA - nsecB;
}



extern void display_arr_in_file(int n);
extern void display_arr_in_console(int n);
extern void fill_arr_from_file(int n);
extern void fill_rand_arr(int n);
extern void fill_arr_from_display(int n);
extern void make_new_arr(int n);

int A[10000];
int B[10000];
FILE *input, *output;

int main(int argc, char **argv) {
  char *arg;
  int n, seed;
  struct timespec start;
  struct timespec end;
  int64_t elapsed_ns;

  if (argc == 1) {
    scanf("%d", &n);
    fill_arr_from_display(n);
    clock_gettime(CLOCK_MONOTONIC, &start);
    make_new_arr(n);
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespecDiff(end, start);
    display_arr_in_console(n);
    printf("Elapsed: %ld ns", elapsed_ns);
    printf("\n");
    return 0;
  } else if (argc == 2) {
    scanf("%d", &n);
    arg = argv[1];
    seed = atoi(arg);
    srand(seed);
    fill_rand_arr(n);
    clock_gettime(CLOCK_MONOTONIC, &start);
    make_new_arr(n);
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespecDiff(end, start);
    display_arr_in_console(n);
    printf("Elapsed: %ld ns", elapsed_ns);
    printf("\n");
    return 0;
  } else if (argc == 3) {
    char *file1 = argv[1];
    char *file2 = argv[2];
    input = fopen(file1, "r");
    output = fopen(file2, "w");
    fscanf(input, "%d", &n);
    fill_arr_from_file(n);
    clock_gettime(CLOCK_MONOTONIC, &start);
    make_new_arr(n);
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespecDiff(end, start);
    display_arr_in_file(n);
    fprintf(output, "Elapsed: %ld ns", elapsed_ns);
    return 0;
  } else {
    return 1;
  }
}
