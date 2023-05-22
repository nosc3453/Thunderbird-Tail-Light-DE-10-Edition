module hex_display (csl, h0, h1, h2, h3, h4, h5);
input [3:0] csl;
output reg [7:0] h0, h1, h2, h3, h4, h5;

`include "Parameters.vh"
parameter a = 8'b1000_1000;
parameter e = 8'b1000_0110;
parameter f = 8'b1000_1110;
parameter d = 8'b1010_0001;
parameter g = 8'b1001_0000;
parameter cap_h = 8'b1000_1001;
parameter h = 8'b1000_1011;
parameter cap_i = 8'b1100_1111;
parameter i = 8'b1110_1111;
parameter l = 8'b1100_0111;
parameter t = 8'b1000_0111;
parameter r = 8'b1010_1111;
parameter z = 8'b1010_0100;
parameter blank = 8'b1111_1111;

always @ (*)
    case (csl)
        IDLE: begin
            h0 = e;
            h1 = l;
            h2 = d;
            h3 = cap_i;
            h4 = blank;
            h5 = blank;
        end
        HAZARD: begin
            h0 = d;
            h1 = r;
            h2 = a;
            h3 = z;
            h4 = a;
            h5 = cap_h;
        end
        RIGHT: begin
            h0 = t;
            h1 = h;
            h2 = g;
            h3 = i;
            h4 = r;
            h5 = blank;
        end
        LEFT: begin
            h0 = t;
            h1 = f;
            h2 = e;
            h3 = l;
            h4 = blank;
            h5 = blank;
        end
        default: begin
            h0 = blank;
            h1 = blank;
            h2 = blank;
            h3 = blank;
            h4 = blank;
            h5 = blank;
        end
    endcase
endmodule