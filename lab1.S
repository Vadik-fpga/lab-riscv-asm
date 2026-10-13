# Lab 1. Вариант 4.
# Массив 5x6. Считаем положительные и отрицательные элементы.
# count(a0=адрес, a1=N, a2=M) -> a0=pos, a1=neg

.data
array:  .word  1, -2,  3, -4,  5, -6
        .word -7,  8, -9, 10,-11, 12
        .word 13,-14, 15,-16, 17,-18
        .word -19,20,-21, 22,-23, 24
        .word 25,-26, 27,-28, 29,-30

msg_pos: .asciiz "Positive: "
msg_neg: .asciiz "\nNegative: "
newline: .asciiz "\n"

.text
.globl main

main:
    la   a0, array          # адрес массива
    li   a1, 5              # N
    li   a2, 6              # M
    jal  ra, count

    mv   s0, a0             # pos
    mv   s1, a1             # neg

    li   a0, 4              # print_string
    la   a1, msg_pos
    ecall

    li   a0, 1              # print_int
    mv   a1, s0
    ecall

    li   a0, 4
    la   a1, msg_neg
    ecall

    li   a0, 1
    mv   a1, s1
    ecall

    li   a0, 4
    la   a1, newline
    ecall

    li   a0, 10             # exit
    ecall

count:
    li   t0, 0              # pos
    li   t1, 0              # neg
    li   t2, 0              # i

outer_loop:
    bge  t2, a1, count_done
    li   t3, 0              # j

inner_loop:
    bge  t3, a2, inner_done

    mul  t4, t2, a2         # i*M
    add  t4, t4, t3         # i*M + j
    slli t4, t4, 2          # *4 байта
    add  t4, a0, t4         # адрес arr[i][j]
    lw   t5, 0(t4)

    blez t5, not_positive   # x <= 0
    addi t0, t0, 1          # pos++
    j    next_elem

not_positive:
    bgez t5, next_elem      # x == 0
    addi t1, t1, 1          # neg++

next_elem:
    addi t3, t3, 1          # j++
    j    inner_loop

inner_done:
    addi t2, t2, 1          # i++
    j    outer_loop

count_done:
    mv   a0, t0
    mv   a1, t1
    ret
