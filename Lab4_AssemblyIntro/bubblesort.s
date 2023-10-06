.data
array_start:   .word 0x400         # Address where the target array starts

# Define an array of 10 integers to load into the target array
values:        .word 89, 63, -55, -107, 42, 98, -425, 203, 0, 303
n:             .word 10

.text

# Function to load integers into the target array
load_array:
    # Load the base address of the target array into register s0
    lw s0, array_start

    # Load the base address of the values array into register t0
    la t0, values

    # Initialize loop variables
    addi s1, zero, 0          # Loop counter
    addi s2, zero, 10         # Number of integers to load

load_loop:
    # Load an integer from the values array
    lw t3, 0(t0)

    # Store the loaded integer in the target array at the current address
    sw t3, 0(s0)

    # Update the array addresses and loop counter
    addi s0, s0, 4    # Move to the next location in the target array
    addi t0, t0, 4    # Move to the next integer in the values array
    addi s1, s1, 1    # Increment the loop counter

    # Check if we've loaded all integers
    bne s1, s2, load_loop


# Bubble Sort Function
bubble_sort:
    # Load the base address of the array into s0
    lw s0, array_start
    # set counter variable to 10
    addi t0, zero, 10

outer_loop:
    li s3, 0         # Initialize swapped to 0
    li s5, 1         # Initialize 1 for true (swapped)

    # Calculate the end address of the array
    addi s1, s0, 40

inner_loop:
	li t5, 0
    # Load sortarray[i] into t1
    lw t1, 0(s0)
    # Load sortarray[i+1] into t2
    lw t2, 4(s0)

    # Compare t1 and t2
    blt t1, t2, no_swap

    # Swap elements
    sw t2, 0(s0)
    sw t1, 4(s0)
    # Set swapped to 1
    li s5, 1

no_swap:
    addi s0, s0, 4    # Increment the array pointer
    bne s0, s1, inner_loop

    # Check if swapped is still true (1)
    bne s5, zero, done

    # Decrement n by 1
    addi t0, t0, -1

    # Repeat the outer loop
    j outer_loop

done:
	# end