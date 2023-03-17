`timescale 1ns / 1ps

module top(
	input wire clk,
	input wire btn_up,
	input wire btn_down,
	output h_sync,
	output v_sync,
	output [2:0] red,
	output [2:0] green,
	output [2:0] blue
    );

// instantiate all modules (create wires)
wire clk_25M;
wire [15:0] h_count;
wire [15:0] v_count;
wire v_enable;

// instantiate all modules (call on all)
clock_divider clock_gen(clk, clk_25M);
horizontal_counter horizontal (clk_25M, v_enable, h_count);
vertical_counter vertical (clk_25M, v_enable, v_count);

// outputs
assign h_sync = (h_count < 96) ? 1'b1:1'b0;
assign v_sync = (v_count < 2) ? 1'b1:1'b0;

// define addressable range
reg range;
always @(*) begin
	range = h_count < 784 && h_count > 143 && v_count < 515 && v_count > 34;
end

// ball; 20 x 20 square
integer ball_x = 5;
integer ball_y = 5;
reg ball;
always @(*) begin
	ball = (h_count > (144 + 20*ball_x) && h_count < (144 + 20*(ball_x+1))) && (v_count > (35 + 20*ball_y) && v_count < (35 + 20*(ball_y+1)));
end

// paddle; 20 x 120 rectangle
integer paddle_x = 3;
integer paddle_y = 12;
reg paddle;

always @(posedge clk) begin
	if (btn_up) paddle_y <= paddle_y - 1;
	else if (btn_down) paddle_y <= paddle_y + 1;
	else paddle_y <= paddle_y;
end

always @(*) begin
	paddle = (h_count > (144 + 20*paddle_x) && h_count < (144 + 20*(paddle_x+1))) && (v_count > (35 + 20*paddle_y) && v_count < (35 + 20*(paddle_y+5)));
end

// separate paint signal
reg [3:0] paint_r, paint_g, paint_b;
always @(*) begin
	paint_r <= (ball || paddle) ? 3'b111 : 3'b010; // white when ball, blue when background
	paint_g <= (ball || paddle) ? 3'b111 : 3'b010;
	paint_b <= (ball || paddle) ? 3'b111 : 3'b111;
end

// colors: paint signal in defined range, black in blanking interval
assign red = (range) ? paint_r:3'd0;
assign green = (range) ? paint_g:3'd0;
assign blue = (range) ? paint_b:3'd0;

endmodule
