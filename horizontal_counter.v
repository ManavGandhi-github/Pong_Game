`timescale 1ns / 1ps

module horizontal_counter(
	input clk_25MHz,
	output reg v_enable = 0,
	output reg [15:0] h_count = 0
    );

	always @ (posedge clk_25MHz)
	begin
		if (h_count < 799) begin
			h_count <= h_count + 1'b1;
			v_enable <= 0; // disable vertical counter
		end
		else begin
			h_count <= 0; // reset horizontal counter
			v_enable <= 1; // trigger vertical counter
		end
	end

endmodule
