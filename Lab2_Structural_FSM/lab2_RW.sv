module new_dff(D,clock,rst,Q);

	input logic D;
	input logic clock;
	input logic rst;
	output logic Q;
	
	always @ (posedge(clock), posedge(rst))
		begin
			if (rst == 1)
				Q <= D;	// Q is reset to 0
			else
				Q <= D;
		end
		
endmodule 




module FSM(input logic clk,
 input logic reset,
 input logic left, right,
 output logic la, lb, lc, ra, rb, rc);
 
 
 
	logic s0, s1, s2, s3, s4, s5 ,s6;
	logic s0a, s0b, s1a, s4a;
	
	
	and a1(s0a, s0, !left, !right);
	or o1(s0b, s0a, s3, s6, reset);
	and a2(s1a, s0, left, !right);
	and a3(s4a, s0, !left, right);
	
	new_dff state3(s1, clk, reset, s2);
	new_dff state4(s2, clk, reset, s3);
	new_dff state6(s4, clk, reset, s5);
	new_dff state7(s5, clk, reset, s6);
	new_dff state1(s0b, clk, reset, s0);
	new_dff state2(s1a, clk, reset, s1);
	new_dff state5(s4a, clk, reset, s4);
	
	logic t1, t2, t3, t4;
	
	or o2(t1, s1, s2, s3);
	or o3(t2, s2, s3);
	and a4(la, t1, !s0);
	and a5(lb, t2, !s0);
	and a6(lc, s3, !s0);

	or o4(t3, s4, s5, s6);
	or o5(t4, s5, s6);
	and a7(ra, t3, !s0);
	and a8(rb, t4, !s0);
	and a9(rc, s6, !s0);

	
endmodule
	