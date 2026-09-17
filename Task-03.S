.text
.globl main
main:
    addi    sp, sp, -32
    
    # Initialize array
    li      x5, 12
    sw      x5, 0(sp)        # array[0] = 12
    li      x5, 5
    sw      x5, 4(sp)        # array[1] = 5
    li      x5, 9
    sw      x5, 8(sp)        # array[2] = 9
    li      x5, 21
    sw      x5, 12(sp)       # array[3] = 21
    li      x5, 3
    sw      x5, 16(sp)       # array[4] = 3

    mv      x10, sp          # x10 = base address of array
    li      x11, 5           # x11 = array length
    
    jal     x1, bubbl       # Call the sorting procedure
    
    addi    sp, sp, 32       # Deallocate stack memory
    
    li      x17, 10          # Exit program cleanly
    ecall

bubbl:
    beq     x10, x0, bubbl_end
    beq     x11, x0, bubbl_end
    
    li      x5, 0                # x5 = i
    
outer:
    bge     x5, x11, bubbl_end   # if i >= len end outer loop
    
    mv      x6, x5          
    
inner:
    bge     x6, x11, end_inner    # if j >= len end inner loop
    
    # Calculate address of a[i]

    slli    x7, x5, 2        # i * 4 (word offset)
    add     x7, x10, x7      # base address + offset
    lw      x28, 0(x7)       # x28 = a[i]
    
    # Calculate address of a[j]
    
    slli    x29, x6, 2       # j * 4 (word offset)
    add     x29, x10, x29    # &a[j] = base address + offset
    lw      x30, 0(x29)      # x30 = a[j]
    
    bge     x28, x30, skip_swap   # skip the swap
    
    # Swap a[i] and a[j]
    sw      x30, 0(x7)       # store a[j] into a[i]
    sw      x28, 0(x29)      # store original a[i] into a[j]
    
skip_swap:
    addi    x6, x6, 1        # j++
    jal     x0, inner
    
end_inner:
    addi    x5, x5, 1        # i++
    jal     x0, outer
    
bubbl_end:
    jalr    x0, 0(x1)        # return to caller