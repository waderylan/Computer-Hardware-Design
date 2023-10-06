module testbench();
		logic clk, reset;
		
		logic	opb5;
		logic [2:0] funct3;
		logic funct7b5;
		logic [1:0] ALUOp;
		logic [2:0] ALUControl;
		logic [2:0] ALUExpected;
		
		logic [31:0] vectornum, errors;
		
		logic [9:0] testvectors[10000:0];

		
aludec dut(opb5, funct3, funct7b5, ALUOp, ALUControl);


always
	
		
		begin
				
					clk=1;#5;
					clk = 0;#5;
		end
		
		
initial
			begin
						$readmemb("aludec.tv", testvectors);
						
						vectornum=0;
						errors=0;
						
						
						reset=1;#22;
						reset=0;
			end
			
always @(posedge clk)
		
		begin
				
				#1;
				
				{ALUOp[1], ALUOp[0], funct3[2], funct3[1], funct3[0], opb5, funct7b5, ALUExpected[2], ALUExpected[1], ALUExpected[0]} = testvectors[vectornum];
		end
		
		
always @(negedge clk)

			
		if(~reset)begin
					
					if (ALUControl[2] !==  ALUExpected[2] || ALUControl[1] !==  ALUExpected[1] || ALUControl[0] !==  ALUExpected[0])begin
							
							// ADD output for the errors here later
							
							errors = errors + 1;
					end
					
					vectornum = vectornum + 1;
					
					
					if (testvectors[vectornum] === 10'bx)begin
							
							$display("%d tests completed with %d errors", vectornum, errors);
							
							$stop;
					end
		end

		
endmodule





					