#include <stdio.h>
#include <stdint.h>

uint32_t divisao1(uint32_t dividendo, uint32_t divisor){
    int resto;
    uint32_t iteracao = 0;
    uint32_t msb;
    //shift
    msb = (unsigned)(dividendo >> 31);
    dividendo = dividendo << 1;
    resto = resto << 1;
    resto = resto | msb;
    printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    for(iteracao = 1; iteracao < 33; iteracao++){
        resto = resto - divisor;
        printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
        if(resto < 0){
            resto = resto + divisor;
            printf("menor\n");
            //shift
            msb = dividendo >> 31;
            dividendo = dividendo << 1;
            resto = resto << 1;
            resto = resto | msb;
        } else {
            printf("maior\n");
            resto = resto - divisor;
            //shift
            msb = dividendo >> 31;
            dividendo = dividendo << 1;
            resto = resto << 1;
            resto = resto | msb;
            dividendo = dividendo | 1;
        }
        printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    }
    resto = resto >> 1;
    printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    return dividendo;
}

uint32_t divisao2(uint32_t dividendo, uint32_t divisor){
    int resto;
    uint32_t iteracao = 0;
    uint32_t msb;
    //shift
    msb = (unsigned)(dividendo >> 31);
    dividendo = dividendo << 1;
    resto = resto << 1;
    resto = resto | msb;
    printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    for(iteracao = 1; iteracao < 33; iteracao++){
        printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
        if(resto < divisor){
            printf("menor\n");
            //shift
            msb = dividendo >> 31;
            dividendo = dividendo << 1;
            resto = resto << 1;
            resto = resto | msb;
        } else {
            printf("maior\n");
            resto = resto - divisor;
            //shift
            msb = dividendo >> 31;
            dividendo = dividendo << 1;
            resto = resto << 1;
            resto = resto | msb;
            dividendo = dividendo | 1;
        }
        printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    }
    resto = resto >> 1;
    printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    return dividendo;
}

int divisaosinal(int dividendo, int divisor){
    int resto;
    int iteracao = 0;
    int msb;
    dividendo = (dividendo < 0) ? -dividendo : dividendo;
    divisor = (divisor < 0) ? -divisor : divisor;

    //shift
    msb = (unsigned)(dividendo >> 31);
    dividendo = dividendo << 1;
    resto = resto << 1;
    resto = resto | msb;
    printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    for(iteracao = 1; iteracao < 33; iteracao++){
        resto = resto - divisor;
        printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
        if(resto < 0){
            resto = resto + divisor;
            printf("menor\n");
            //shift
            msb = dividendo >> 31;
            dividendo = dividendo << 1;
            resto = resto << 1;
            resto = resto | msb;
        } else {
            printf("maior\n");
            resto = resto - divisor;
            //shift
            msb = dividendo >> 31;
            dividendo = dividendo << 1;
            resto = resto << 1;
            resto = resto | msb;
            dividendo = dividendo | 1;
        }
        printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    }
    resto = resto >> 1;
    printf("%08x %08x %08x %08x\n", iteracao, divisor, resto, dividendo);
    return dividendo;
}

int main(){
    printf("%d\n", divisaosinal(0x90357274, 0x12341234));
    printf("%d\n", divisaosinal(0x12341234, 0x90357274));
    return 0;
}
