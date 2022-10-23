#include <stdio.h>
#include <stdlib.h>

extern int A[];
extern int B[];
extern FILE *input, *output;

void fill_rand_arr(int n) {
  for (int i = 0; i < n; ++i) {
    A[i] = -100 + rand() % 100;
  }
}

void fill_arr_from_file(int n) {
  int num;
  for (int i = 0; i < n; ++i) {
    fscanf(input, "%d", &num);
    A[i] = num;
  }
}

void fill_arr_from_display(int n) {
  for (int i = 0; i < n; ++i) {
    scanf("%d", &A[i]);
  }
}

void make_new_arr(int n) {
  for (int i = 0; i < n - 1; ++i) {
    B[i] = A[i + 1] - A[i];
  }
}

void display_arr_in_file(int n) {
  for (int i = 0; i < n - 1; ++i) {
    fprintf(output, "%d ", B[i]);
  }
  fprintf(output, "\n");
}

void display_arr_in_console(int n) {
  for (int i = 0; i < n - 1; ++i) {
    printf("%d ", B[i]);
  }
  printf("\n");
}
