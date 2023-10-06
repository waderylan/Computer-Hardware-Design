.data
start_address:  .word   0x300  # Define the start address
destination: .word   0x400  # Destination address
values:         .word   0x1234ABCD, 0xEF567890, 0xABCDEF12, 0x98765432, 0x12345678, 0x2468ACE1, 0x98BA76CD, 0x19FA28EB
count:          .word   8      # Number of words to load

.text
main:
    lw t0, start_address		# Load the start address into t0
    la t1, values		   		# Load the values address into t1
    addi t2, zero, 8		    # Load the count into t2

# fill memory from 0x300 to 0x31c with 8 words
load_words:
    lw t3, 0(t1)				# Load a value from the data section
    sw t3, 0(t0)			    # Store the value in memory at the specified address (t0)
    
    # Increment the source and destination addresses
    addi t0, t0, 4
    addi t1, t1, 4
    
    addi t2, t2, -1			    # Decrement the count
    bnez t2, load_words			# Repeat the loop if the count is not zero
    
    
lw t6, start_address
lw t5, destination
addi t2, zero, 8

# fill memory from 0x400 to 0x41c with the little endian versions of the previous data
convert_loop:
    # Extract bytes from the big-endian word and store them in reverse order
    lb t4, 3(t6)
    sb t4, 0(t5)

    lb t4, 2(t6)
    sb t4, 1(t5)

    lb t4, 1(t6)
    sb t4, 2(t5)

    lb t4, 0(t6)
    sb t4, 3(t5)

    # Increment source and destination addresses
    addi t6, t6, 4
    addi t5, t5, 4
    
    addi t2, t2, -1			   	# Decrement the count

    bnez t2, convert_loop		# Repeat the loop if the count is not zero

