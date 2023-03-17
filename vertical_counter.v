`timescale 1ns / 1ps

module vertical_counter(
	input clk_25MHz,
	input v_enable,
	output reg [15:0] v_count = 0
    );

	always @ (posedge clk_25MHz)
	begin
		if (v_enable == 1'b1) begin
			if (v_count < 524)
				v_count <= v_count + 1'b1;
			else 
				v_count <= 0; // reset vertical counter	
		end
	end
	
endmodule
