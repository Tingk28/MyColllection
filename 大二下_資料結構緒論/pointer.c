#include <stdio.h>
main () {
    int y = 2;
    int x = 5;
    int *p;  // p is a pointer to int
    int **q; // q is a pointer to pointer to integer
    p = &x;  // 把p 指到 x
    q = &p;  // 把 q 指到 p
    *q = &x; // 透過q把p的內容改為指到y
    printf("%d\n", *p); // 會印出2
    printf("%d\n", **q); // 會印出2
}  
