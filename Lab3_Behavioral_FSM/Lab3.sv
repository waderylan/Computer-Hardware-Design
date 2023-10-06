module Lab3(
	input logic clk, rst, N, S, E, W,
	output logic WIN, DIE, 
	output logic [6:0] curr_room);
	
	 	
	// sw represents when the sword has been collected
	/// sss represents when the player is currently in the Secret Sword Stash
	reg sw, sss;

	sword_FSM sword(clk, rst, sss, sw);
	room_FSM rooms(clk, rst, N, S, E, W, sw, sss, WIN, DIE, curr_room);
	
endmodule



module room_FSM(
input logic clk, rst, N, S, E, W, sw,
output logic sss, WIN, DIE, 
output logic [6:0] state);

typedef enum logic [6:0] {
	CC = 7'b0000001,
	TT = 7'b0000010,
	RR = 7'b0000100,
	SS = 7'b0001000,
	DD = 7'b0010000,
	GG = 7'b0100000,
	VV = 7'b1000000
} state_type;

state_type current_state, next_state;

always_ff @(posedge clk, posedge rst)
	if (rst) begin
		current_state <= CC;
		end
	else begin		
		current_state <= next_state;
		end
	



always_comb
	case(current_state)
		CC:		if(E) begin
						next_state = TT; 
						end
					else next_state = CC;
					
		TT:		if (W) next_state = CC;
					else if (S) next_state = RR;
					else next_state = TT;
					
		RR:		if (W) begin
						next_state = SS;
						end
					else if (E) next_state = DD;
					else if (N) next_state = TT;
					else next_state = RR;
					
		SS:		if (E) next_state = RR;
					else next_state = SS;
					
		DD:		if (sw) begin
							next_state = VV;
							end
					else begin
							next_state = GG;
							end
							
		default: next_state = current_state;
		
	endcase

	assign sss = (current_state == SS);
	assign WIN = (current_state == VV);
	assign DIE = (current_state == GG);
	assign state = current_state;


endmodule



module sword_FSM(
input logic clk, rst, sss,
output logic sw);

typedef enum logic {
	yes = 1'b1,
	no  = 1'b0
} sword_state;

sword_state current_sword, next_sword;

always_ff @(posedge clk, posedge rst)
	if (rst) begin
		current_sword <= no;
		sw <= current_sword;
		end
	else begin
		current_sword = next_sword;
		sw <= current_sword;
		end


always_comb
	case(current_sword)
		
		yes: 	next_sword = yes;
		
		no: 	if (sss) next_sword = yes;
				else next_sword = no;
	endcase

		
		
endmodule

