.text:
init:
    jal main
    addi $a0, $v0, 0
    addi $v0, $zero, 17
    syscall

# divisao(int x, int y) -> int quociente, int resto
#         $a0    $a1       $v0            $v1
# pilha (-20):
# 00: dividendo
# 04: divisor
# 08: resto
# 12: iteracao
# 16: $ra
#
# registradores:
# $t0: resto_hi
# $t1: resto_lo/dividendo
# $t2: divisor
# $t3: iteracao
# $t4: MSB resto_lo
# $t5: testes
divisao:
    # prologo:
    addi $sp, $sp, -20 #ajustando a pilha
    sw $ra, 16($sp) #salvando $ra na pilha

    # corpo:
    addi $t0, $zero, 0 #t0(resto_hi) = 0
    addi $t1, $a0, 0 #t1(resto_lo) = x
    addi $t2, $a1, 0 #t2(divisor) = y
    addi $t3, $zero, 0 #t3(iteracao) = 0
    
    #salvando valores na pilha
    sw $t1, 0($sp) #salvando dividendo na pilha
    sw $t2, 4($sp) #salvando divisor na pilha
    sw $t0, 8($sp) #salvando resto na pilha
    sw $t3, 12($sp) #salvando iteracao na pilha

    #printando valores (iteracao, divisor, resto_hi, resto_lo)
    addi $a0, $t3, 0
    addi $a1, $t2, 0
    addi $a2, $t0, 0
    addi $a3, $t1, 0
    jal print
    
    #pegando valores da pilha
    lw $t1, 0($sp) #pegando dividendo na pilha
    lw $t2, 4($sp) #pegando divisor na pilha
    lw $t0, 8($sp) #pegando resto na pilha
    lw $t3, 12($sp) #pegando iteracao na pilha

    #resto = resto << 1
    srl $t4, $t1, 31 #t4 = MSB resto_lo
    sll $t1, $t1, 1 #resto_lo = resto_lo << 1
    sll $t0, $t0, 1 #resto_hi = resto_hi << 1
    or $t0, $t0, $t4 #lsb resto_hi = msb antigo resto_lo

    #salvando valores na pilha
    sw $t1, 0($sp) #salvando dividendo na pilha
    sw $t2, 4($sp) #salvando divisor na pilha
    sw $t0, 8($sp) #salvando resto na pilha
    sw $t3, 12($sp) #salvando iteracao na pilha

    #printando valores (iteracao, divisor, resto_hi, resto_lo)
    addi $a0, $t3, 0
    addi $a1, $t2, 0
    addi $a2, $t0, 0
    addi $a3, $t1, 0
    jal print

    j divisao_for_teste

divisao_for_codigo:
    #pegando valores da pilha
    lw $t1, 0($sp) #pegando dividendo na pilha
    lw $t2, 4($sp) #pegando divisor na pilha
    lw $t0, 8($sp) #pegando resto na pilha
    lw $t3, 12($sp) #pegando iteracao na pilha
    #iteracao = iteracao + 1
    addi $t3, $t3, 1

divisao_for_if_teste:
    #if (resto_hi < divisor)
    sltu $t5, $t0, $t2
    bne $t5, $zero, divisao_for_if_v

divisao_for_if_f:
    #resto = resto - divisor
    subu $t0, $t0, $t2
    #resto = resto << 1
    srl $t4, $t1, 31 #t4 = MSB resto_lo
    sll $t1, $t1, 1 #resto_lo = resto_lo << 1
    sll $t0, $t0, 1 #resto_hi = resto_hi << 1
    or $t0, $t0, $t4 #lsb resto_hi = msb antigo resto_lo
    
    #resto[0] = 1
    ori $t1, $t1, 1

    j divisao_for_cont

divisao_for_if_v:
    #resto = resto << 1
    srl $t4, $t1, 31 #t4 = MSB resto_lo
    sll $t1, $t1, 1 #resto_lo = resto_lo << 1
    sll $t0, $t0, 1 #resto_hi = resto_hi << 1
    or $t0, $t0, $t4 #lsb resto_hi = msb antigo resto_lo

    #resto[0] = 0
    #vai ser 0 de qualquer jeito

divisao_for_cont:
    #salvando valores na pilha
    sw $t1, 0($sp) #salvando dividendo na pilha
    sw $t2, 4($sp) #salvando divisor na pilha
    sw $t0, 8($sp) #salvando resto na pilha
    sw $t3, 12($sp) #salvando iteracao na pilha

    #printando valores (iteracao, divisor, resto_hi, resto_lo)
    addi $a0, $t3, 0
    addi $a1, $t2, 0
    addi $a2, $t0, 0
    addi $a3, $t1, 0
    jal print

divisao_for_teste:
    #if (iteracao < 32)
    slti $t5, $t3, 32
    bne $t5, $zero, divisao_for_codigo

divisao_fim:
    #iteracao = iteracao + 1
    addi $t3, $t3, 1

    #resto_hi = resto_hi >> 1
    srl $t0, $t0, 1
    
    #salvando valores na pilha
    sw $t1, 0($sp) #salvando dividendo na pilha
    sw $t2, 4($sp) #salvando divisor na pilha
    sw $t0, 8($sp) #salvando resto na pilha
    sw $t3, 12($sp) #salvando iteracao na pilha

    #printando valores (iteracao, divisor, resto_hi, resto_lo)
    addi $a0, $t3, 0
    addi $a1, $t2, 0
    addi $a2, $t0, 0
    addi $a3, $t1, 0
    jal print
    
    #pegando valores da pilha
    lw $t1, 0($sp) #pegando dividendo na pilha
    lw $t2, 4($sp) #pegando divisor na pilha
    lw $t0, 8($sp) #pegando resto na pilha
    lw $t3, 12($sp) #pegando iteracao na pilha

    # epilogo
    addi $v0, $t1, 0 #v0 = quociente
    addi $v1, $t0, 0 #v1 = resto
    lw $ra, 16($sp) #recuperando $ra
    addi $sp, $sp, 20 #reajustando pilha
    jr $ra


#print(a0, a1, a2, a3)
print:
    # print a0
    addi $v0, $zero, 36
    syscall

    # print ' '
    addi $v0, $zero, 11
    addi $a0, $zero, 32
    syscall

    # print a1
    addi $v0, $zero, 36
    addi $a0, $a1, 0
    syscall
    
    # print ' '
    addi $v0, $zero, 11
    addi $a0, $zero, 32
    syscall

    # print a2
    addi $v0, $zero, 36
    addi $a0, $a2, 0
    syscall
    
    # print ' '
    addi $v0, $zero, 11
    addi $a0, $zero, 32
    syscall

    # print a3
    addi $v0, $zero, 36
    addi $a0, $a3, 0
    syscall
    
    # print '\n'
    addi $v0, $zero, 11
    addi $a0, $zero, 10
    syscall

    jr $ra


#int main()->0
#pilha: -12
#sp+00: x
#sp+04: y
#sp+08: $ra
main:
    # prologo:
    addi $sp, $sp, -12
    sw $ra, 8($sp)

    # corpo:
    #$a0 = 0x90357274
    lui $a0, 0x9035
    ori $a0, $a0, 0x7274
    
    #$a1 = 0x12341234
    lui $a1, 0x1234
    ori $a1, $a1, 0x1234

    jal divisao

    # print '\n'
    addi $v0, $zero, 11
    addi $a0, $zero, 10
    syscall
    
    #$a0 = 0x12341234
    lui $a0, 0x1234
    ori $a0, $a0, 0x1234
    
    #$a1 = 0x90357274
    lui $a1, 0x9035
    ori $a1, $a1, 0x7274

    jal divisao

    # epilogo:
    addi $v0, $zero, 0
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

