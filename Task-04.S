.text
.globl main

main:

    li      x10, 3           # a = 3
    li      x11, 4           # b = 4
    
    # Call the sum_sq procedure
    jal     x1, sum_sq
    
    # Result (25) is now in x10. Exit cleanly.
    li      x17, 10
    ecall

sum_sq:
   
    addi    sp, sp, -16      # Adjust stack for 3 items
    sw      x1, 8(sp)        # Save return address
    sw      x11, 4(sp)       # Save argument 'b' so it isn't lost
    
  
    jal     x1, square       # returns a^2 in x10
    sw      x10, 0(sp)       # Save a^2 onto the stack
    

    lw      x10, 4(sp)       # Load b from stack into x10
    jal     x1, square       # returns b^2 in x10
    
    
    lw      x5, 0(sp)        
    add     x10, x5, x10     # x10 = a^2 + b^2
    
   
    lw      x1, 8(sp)        # Restore return address
    addi    sp, sp, 16       # Pop stack
    jalr    x0, 0(x1)        # Return to main

square:
    mul     x10, x10, x10  
    jalr    x0, 0(x1)        # Return 