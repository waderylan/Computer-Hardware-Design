module aludec(input logic opb5,
		input logic [2:0] funct3,
		input logic funct7b5, 
		input logic [1:0] ALUOp,
		output logic [2:0] ALUControl);
		
		
		// structural SystemVerilog body goes here
		logic s1, s2, s3;
		
		and a1(s1, opb5, funct7b5);
		or o2(s2, funct3[1], s1);
		and a2(s3, ALUOp[1], ~funct3[0], s2);
		
		
		or o1(ALUControl[0], ALUOp[0], s3); 
		and a3(ALUControl[1], ALUOp[1], funct3[2], funct3[1]);
		and a4(ALUControl[2], ALUOp[1], ~funct3[2], funct3[1]);

	
 

		
		
endmodule

