#include <stdio.h>

void count(int arr[5][6], int n, int m, int *pos, int *neg) {
    *pos = 0;
    *neg = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (arr[i][j] > 0) (*pos)++;
            else if (arr[i][j] < 0) (*neg)++;
        }
    }
}

int main() {
    int arr[5][6] = {
        { 1, -2,  3, -4,  5, -6},
        {-7,  8, -9, 10,-11, 12},
        {13,-14, 15,-16, 17,-18},
        {-19,20,-21, 22,-23, 24},
        {25,-26, 27,-28, 29,-30}
    };
    int pos, neg;
    count(arr, 5, 6, &pos, &neg);
    printf("Positive: %d\n", pos);
    printf("Negative: %d\n", neg);
    return 0;
}
