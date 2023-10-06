module lab3_testbench();
	logic clk, reset;
	logic game_rst, N, S, E, W, WIN, DIE;
	logic [6:0] curr_room;
	logic expected_WIN, expected_DIE;
	logic [6:0] expected_room;
	logic [31:0] vectornum, errors;
	logic [13:0] testvectors[10000:0];
	
	
	logic master_rst;
	assign master_rst = game_rst || reset;
	// this allows the test vectors to apply a reset and a reset to be declared at the start of the test bench
	
	Lab3 dut(clk, master_rst, N, S, E, W, WIN, DIE, curr_room);
	
	// generate clock
	always 
		begin
			clk=1; #5; clk=0; #5; 
		end

	// at start of test, load vectors and pulse reset
	initial 
		begin
			$readmemb("adventure.tv", testvectors); 
			vectornum = 0; errors = 0; 
			reset = 1; #22; reset = 0;  
		end
		
	
	always @(posedge clk) 
		begin
			if (!reset) begin
				#1; {game_rst, N, S, E, W, expected_WIN, expected_DIE, expected_room} = testvectors[vectornum]; 
				end
		end
		
		
		
	always @(negedge clk) 
		if (~reset) begin // skip during reset
			if ({WIN, DIE, curr_room} !== {expected_WIN, expected_DIE, expected_room}) begin // check result
				$display("Error: inputs = %b", {N, S, E, W});
				$display(" outputs = %b %b %b (%b %b %b expected)", 
					WIN, DIE, curr_room, expected_WIN, expected_DIE, expected_room); 
				errors = errors + 1; 
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 8'bx) begin 
				$display("%d tests completed with %d errors", vectornum, errors); 
				$stop; 
			end 
		end 
		

			
			
endmodule
		
		
		
		
		
		
		