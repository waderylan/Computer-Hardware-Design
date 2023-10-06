main:
	addi s1, zero, 9    # set a register equal to 9
    j check				# jump to the substraction loop

check:
	blt s0, s1, false	# if the number is less than 9, it is not divisible by 9
    beq s0, s1, true	# if the number equals 9, it is divisible by 9
    sub s0, s0, s1		# subtract 9 from the number
    j check				# repeat loop



true: 
	addi s0, zero, 1	# set s0 to 1 since it is divisible by 9
	j end				# end of program


false:
	addi s0, zero, 0	# set s0 to 0 since it is not divisible by 9
    j end				# end of program
    
end: