`timescale 1ns / 1ps

module game_clk (clk, game_clock, score);
	 
	 input clk;
	 input score;
	 output reg game_clock = 0;
	 
	 integer speed = 10000000;
	 reg [24:0] count = 25'd0;
	 
always @ (posedge clk)
begin
	if (count == speed) 
		begin
			game_clock <= ~game_clock;
			count <= 25'd0;
			if (speed > 500000) speed <= 10000000 - (score)*1000000;
		end
	else
		begin
			count <= count + 25'd1;
		end
end

endmodule

