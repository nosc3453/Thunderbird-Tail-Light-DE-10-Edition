module NSL(input clock, input [3:0] cur, input [1:0] KEY, input [9:0] SW, output reg [3:0] nxt); 
`include "Parameters.vh"

always @ (*) begin
    if      (SW[0])           nxt = HAZARD;
    else if (SW[1] && KEY[1]) nxt = LEFT;
    else if (SW[1])           nxt = RIGHT;
    else                      nxt = IDLE;
end
endmodule