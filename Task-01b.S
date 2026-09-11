main:
    li x20, 5   #n
    li x22, 1
    addi sp, sp, -4
    sw   x20, 0(sp)       # save argument n

    li x21, 1   #acc
    jal x1, fact
    ecall

fact:

while:
    mul x21, x21, x20
    addi x20, x20, -1
    bge x20, x22, while

jalr x0, 0(x1)

Exit:
    lw   x20, 0(sp)   
    addi sp, sp, 4



