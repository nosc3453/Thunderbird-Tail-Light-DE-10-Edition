module OL(input [3:0] cur, input clock, input reset_n, input [9:0] SW, output reg [9:0] LEDR);
`include "Parameters.vh"
reg [1:0] counter;

always @ (posedge clock, negedge reset_n) begin
    if (~reset_n) counter <= 0;
    else counter <= counter + 1;
end

always @ (*) begin
    case (cur)
        IDLE: begin
            if (~reset_n) LEDR[9:0] = 0;
            else begin
                LEDR[9:7] = {SW[2], SW[2], SW[2]};
                LEDR[2:0] = {SW[2], SW[2], SW[2]};
                LEDR[6:3] = 0;
            end
        end
        HAZARD: begin
            if (counter[0] == 0) begin
                LEDR[2:0] = 3'b000;
                LEDR[9:7] = 3'b000;
                LEDR[6:3] = 0;
            end
            else begin
                LEDR[2:0] = 3'b111;
                LEDR[9:7] = 3'b111;
                LEDR[6:3] = 0;
            end
        end
        RIGHT: begin
            case (counter)
                0: begin
                    LEDR[2:0] = 3'b000;
                    LEDR[9:7] = {SW[2], SW[2], SW[2]};
                    LEDR[6:3] = 0;
                end
                1: begin
                    LEDR[2:0] = 3'b100;
                    LEDR[9:7] = {SW[2], SW[2], SW[2]};
                    LEDR[6:3] = 0;
                end
                2: begin
                    LEDR[2:0] = 3'b110;
                    LEDR[9:7] = {SW[2], SW[2], SW[2]};
                    LEDR[6:3] = 0;

                end
                3: begin
                    LEDR[2:0] = 3'b111;
                    LEDR[9:7] = {SW[2], SW[2], SW[2]};
                    LEDR[6:3] = 0;
                end
            endcase
        end
        LEFT: begin
            case (counter)
                0: begin
                    LEDR[9:7] = 3'b000;
                    LEDR[2:0] = {SW[2], SW[2], SW[2]};
                    LEDR[6:3] = 0;
                end
                1: begin
                    LEDR[9:7] = 3'b001;
                    LEDR[2:0] = {SW[2], SW[2], SW[2]};
                    LEDR[6:3] = 0;
                end
                2: begin 
                LEDR[9:7] = 3'b011;
                LEDR[2:0] = {SW[2], SW[2], SW[2]};
                LEDR[6:3] = 0;
                end
                3: begin
                    LEDR[9:7] = 3'b111;
                    LEDR[2:0] = {SW[2], SW[2], SW[2]};
                    LEDR[6:3] = 0;
                end
            endcase
        end
        default: LEDR = 10'b0000_0000_00;
    endcase
end
endmodule