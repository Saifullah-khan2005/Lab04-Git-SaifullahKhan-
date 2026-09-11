
main:
    addi x20, x0, 5        # num= 5
    jal x1, ntri           # Call the recursive ntri function
    addi x17, x0, 10       
    ecall                  # Exit program

ntri:
    addi sp, sp, -8        
    sw x1, 4(sp)           
    sw x20, 0(sp)          

    addi x5, x0, 1         
    ble x20, x5, base      # num <= 1 base_case

    addi x20, x20, -1      # Set argument to num - 1
    jal x1, ntri           

    lw x6, 0(sp)           
    add x20, x20, x6       # num + (num -1)
    lw x1, 4(sp)           
    addi sp, sp, 8         
    jalr x0, 0(x1)         

base:
    addi x20, x0, 1        
    lw x1, 4(sp)           
    addi sp, sp, 8         
    jalr x0, 0(x1)         