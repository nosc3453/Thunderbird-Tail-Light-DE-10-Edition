module clock_divider ( input clock_in, reset_n, output reg clock_out);
reg [31:0] clock_divider;
parameter divide_by = 0;

always @ (posedge clock_in, negedge reset_n) begin
    if (~reset_n) begin
        clock_out = 0;
        clock_divider = 0;
    end
    else begin
        if (clock_divider != divide_by - 1)
            clock_divider <= clock_divider + 1;
        else begin
            clock_out <= ~clock_out;
            clock_divider <= 0;
        end
    end
end
endmodule