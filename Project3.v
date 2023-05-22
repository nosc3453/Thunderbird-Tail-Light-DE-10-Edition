module Project3 (ADC_CLK_10, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
`include "Parameters.vh"
input ADC_CLK_10;
input [1:0] KEY;
input [9:0] SW;
output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output [9:0] LEDR;
wire clock1, clock2;
wire [3:0] curState, nxtState, q;
wire [2:0] switches;
wire [1:0] buttons;
reg  [2:0] counter = 0;

clock_divider #(2000000) cd_1 (.clock_in(ADC_CLK_10), .reset_n(KEY[0]), .clock_out(clock1));
clock_divider #(8)       cd_2 (.clock_in(clock1), .reset_n(KEY[0]), .clock_out(clock2));

always @(posedge clock2) begin
    if (KEY[0] == 0 || counter == 5) counter = 0;
    else counter <= counter + 1;
end

mem automation (.address({5'b0, counter}), .clock(clock2), .q(q));
assign buttons[0] = KEY[0];
assign buttons[1] = (SW[9]) ? q[0]   : KEY[1];
assign switches   = (SW[9]) ? q[3:1] : SW[2:0];

CSL     curr_state (.clock(clock1), .reset_n(buttons[0]), .nxt(nxtState), .cur(curState));
NSL     next_state (.clock(clock1), .cur(curState), .nxt(nxtState), .KEY(buttons), .SW(switches));
OL         to_leds (.cur(curState), .LEDR(LEDR), .clock(clock1), .reset_n(buttons[0]), .SW(switches));
hex_display to_hex (.csl(curState), .h0(HEX0), .h1(HEX1), .h2(HEX2), .h3(HEX3), .h4(HEX4), .h5(HEX5));
endmodule