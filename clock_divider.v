`timescale 1ns / 1ps

// div_value = 100 MHz/(2*desired_freq) - 1
module clock_divider #(parameter div_value = 1) (
	input wire clk, // 100 MHz default input, very fast
	output reg divided_clk = 0 // slow down to 25 MHz
    );

// counter-based, use counter to slow down cycle
integer counter = 0;

always @ (posedge clk)
begin
	// keep counting until div_value
	if (counter == div_value)
		counter <= 0; // reset count
	else
		counter <= counter + 1;
end

// divide clock
always @ (posedge clk)
begin
	if (counter == div_value)
		divided_clk <= ~divided_clk; // flip the signal
	else
		divided_clk <= divided_clk; // keep the signal
end

endmodule
