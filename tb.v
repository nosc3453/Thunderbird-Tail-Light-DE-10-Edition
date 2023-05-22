`timescale 1 ns /  100 ps
module tb();
reg [1:0] key;
reg [9:0] sw;
reg clk;
wire [9:0] ledr;
wire [7:0] HEX0;
Project3 U0 (.ADC_CLK_10(clk), .KEY(key[1:0]), .SW(sw[9:0]), .HEX0(HEX0), .LEDR(ledr[9:0]));
always #1 clk = !clk;
initial
    begin
        $dumpfile("Project3.vcd");
        $dumpvars;
        clk = 0;
        key = 2'b10;
        sw = 10'b00_0000_0010;
   #10  key = 2'b11;
   #150 key = 2'b01;
   #150 key = 2'b11;
   #150 key = 2'b10;
   #150 key = 2'b11;
   #150 key = 2'b00;
   #150 key = 2'b01;
   #150 $finish;
    end
endmodule