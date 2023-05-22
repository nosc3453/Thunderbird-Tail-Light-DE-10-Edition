module CSL(input clock, input reset_n, input [3:0] nxt, output reg [3:0] cur); 
`include "Parameters.vh"
always @(posedge clock, negedge reset_n)
    if (reset_n == 0) cur <= IDLE;
    else cur <= nxt;
endmodule