#include <stdio.h>
main () {
    int y = 2;
    int x = 5;
    int *p;  // p is a pointer to int
    int **q; // q is a pointer to pointer to integer
    p = &x;  // ��p ���� x
    q = &p;  // �� q ���� p
    *q = &x; // �z�Lq��p�����e�אּ����y
    printf("%d\n", *p); // �|�L�X2
    printf("%d\n", **q); // �|�L�X2
}  
