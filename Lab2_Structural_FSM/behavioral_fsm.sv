module behavioral_fsm(input logic clk,
 input logic reset,
 input logic left, right,
 output logic la, lb, lc, ra, rb, rc);
 
 
 
 

	reg [6:0] states = {0,0,0,0,0,0,0};
	

	
	
	
	always @(posedge clk)
		begin
			#1;
			if (states[0] == 1 && left == 1) begin
				states[1] = 1;
				states[0] = 0;
				end
			else if (states[0] == 1 && right == 1) begin
				states[4] = 1;
				states[0] = 0;
				end
			else if (states[1] == 1) begin
				states[2] = 1;
				states[1] = 0;
				end
			else if (states[2] == 1) begin
				states[3] = 1;
				states[2] = 0;
				end
			else if (states[3] == 1) begin
				states[0] = 1;
				states[3] = 0;
				end
			else if (states[4] == 1) begin
				states[5] = 1;
				states[4] = 0;
				end
			else if (states[5] == 1) begin
				states[6] = 1;
				states[5] = 0;
				end
			else if (states[6] == 1) begin
				states[0] = 1;
				states[6] = 0;
				end
			else begin
				states[0] = 1;
				end
			
			
			la = (states[1] || states[2] || states[3]);
			lb = (states[2] || states[3]);
			lc = states[3];
			ra = (states[4] || states[5] || states[6]);
			rb = (states[5] || states[6]);
			rc = states[6];
		
		end

endmodule
	
			
				
				
				