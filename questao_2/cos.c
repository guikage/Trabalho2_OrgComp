#include <stdio.h>

double pot(double x, int pot){
    double res = 1;
    for(int i = 0; i < pot; i++){
        res *= x;
    }
    return res;
}

int fat(int n){
    if(!n) return 1;
    int n2 = n;
    for(int i = 1; i < n; i++){
        n2 *= i;
    }
    return n2;
}


double cos(double x){
    double num;
    int den;
    double mult;
    double res = 0;
    for(int i = 0; i < 8; i++){
        num = pot(-1, i);
        den = fat(2*i);
        mult = pot(x, 2*i);
        num = num / den;
        //num = num * mult;
        res = res + num;
        printf("%lf\n", res);
    }
    return res;
}

double grad(double x){
    return (double)(x / 180) * 3.1415926535897932;
}

int main(){
    double x;
    printf("Digite o angulo: ");
    scanf("%lf", &x);
    double y = grad(x);
    printf("cos(%g) = %f\n", x, cos(y));
    return 0;
}
