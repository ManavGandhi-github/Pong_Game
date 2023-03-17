`timescale 1ns / 1ps

module tb;

reg clk = 0;
wire h_sync;
wire v_sync;
wire [3:0] red;
wire [3:0] green;
wire [3:0] blue;

top uut(.clk(clk), .h_sync(h_sync), .v_sync(v_sync), .red(red), .green(green), .blue(blue));
always #5 clk = ~clk;

endmodule
