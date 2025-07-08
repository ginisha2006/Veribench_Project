module digital_filter #(parameter DATA_WIDTH=16, COEFF_WIDTH=16, NUM_TAPS=32) (
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] data_out,
    input [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);
    reg [DATA_WIDTH-1:0] acc;
    always @(posedge clk) begin
        if (rst) begin
            acc <= 0;
        end else begin
            acc <= acc << 1;
            acc[0] <= data_in & coeff[acc[DATA_WIDTH-1]];
        end
    end
    assign data_out = acc;
endmodule