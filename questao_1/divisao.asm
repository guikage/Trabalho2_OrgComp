.data:
    var_x: .word 0x90357274
    var_y: .word 0x12341234

.text:

la $a0, var_x
la $a1, var_y
lw $a0, 0($a0)
lw $a1, 0($a1)

    
# divisao(int x, int y) -> int quociente, int resto
#         $a0    $a1       $v0            $v1
# pilha (-8):
# 00: x
# 04: y
#
# registradores:
# $t0: resto_hi
# $t1: resto_lo
# $t2: divisor
# $t3: iteracao
# $t4: MSB resto_lo
# $t5: testes
divisao:
    # prologo:
    addi $sp, $sp, -8 #ajustando a pilha
    sw $a0, 0($sp) #salvando x na pilha
    sw $a1, 4($sp) #salvando y na pilha

    # corpo:
    addi $t0, $zero, 0 #t0(resto_hi) = 0
    lw $t1, 0($sp) #t1(resto_lo) = x
    lw $t2, 4($sp) #t2(divisor) = y
    addi $t3, $zero, 0 #t3(iteracao) = 0

    #resto = resto << 1
    srl $t4, $t1, 31 #t4 = MSB resto_lo
    sll $t1, $t1, 1 #resto_lo = resto_lo << 1
    sll $t0, $t0, 1 #resto_hi = resto_hi << 1
    or $t0, $t0, $t4 #lsb resto_hi = msb antigo resto_lo

    j divisao_for_teste

divisao_for_codigo:
    #iteracao = iteracao + 1
    addi $t3, $t3, 1
    #resto_hi = resto_hi - divisor
    subu $t0, $t0, $t2

divisao_for_if_teste:
    #if (resto_hi < 0)
    slti $t5, $t0, 0
    bne $t5, $zero, divisao_for_if_v

divisao_for_if_f:
    #resto = resto << 1
    srl $t4, $t1, 31 #t4 = MSB resto_lo
    sll $t1, $t1, 1 #resto_lo = resto_lo << 1
    sll $t0, $t0, 1 #resto_hi = resto_hi << 1
    or $t0, $t0, $t4 #lsb resto_hi = msb antigo resto_lo
    
    #resto[0] = 1
    ori $t1, $t1, 1

    j divisao_for_teste

divisao_for_if_v:
    #resto_hi = resto_hi + divisor
    addu $t0, $t0, $t2
    
    #resto = resto << 1
    srl $t4, $t1, 31 #t4 = MSB resto_lo
    sll $t1, $t1, 1 #resto_lo = resto_lo << 1
    sll $t0, $t0, 1 #resto_hi = resto_hi << 1
    or $t0, $t0, $t4 #lsb resto_hi = msb antigo resto_lo

    #resto[0] = 0
    #vai ser 0 de qualquer jeito

divisao_for_teste:
    #if (iteracao < 32)
    slti $t5, $t3, 32
    bne $t5, $zero, divisao_for_codigo

divisao_fim:
    #iteracao = iteracao + 1
    addi $t3, $t3, 1

    #resto_hi = resto_hi >> 1
    srl $t0, $t0, 1

    # epilogo
    addi $v0, $t1, 0 #v0 = quociente
    addi $v1, $t0, 0 #v1 = resto

    jr $ra


