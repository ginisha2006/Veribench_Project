module digital_filter #(
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter NUM_TAPS = 32
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    input [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

reg [DATA_WIDTH-1:0] delay_line[NUM_TAPS];
wire [DATA_WIDTH+COEFF_WIDTH-1:0] product[NUM_TAPS];

always @(posedge clk or posedge rst)
begin
    if(rst)
        for(int i=0; i<NUM_TAPS; i=i+1)
            delay_line[i] <= 'd0;
    else
        begin
            delay_line[0] <= data_in;
            for(int i=0; i<NUM_TAPS-1; i=i+1)
                delay_line[i+1] <= delay_line[i];
        end
end

genvar i;
generate
    for(i=0; i<NUM_TAPS; i=i+1)
        assign product[i] = {{(COEFF_WIDTH){delay_line[i][DATA_WIDTH-1]}}, delay_line[i]} * coeff[i];
endgenerate

assign data_out = sum(product);

function [DATA_WIDTH-1:0] sum;
    input [DATA_WIDTH+COEFF_WIDTH-1:0] arr [];
    integer j;
    begin
        sum = 0;
        for(j=0; j<NUM_TAPS; j=j+1)
            sum = sum + arr[j][DATA_WIDTH-1:0];
    end
endfunction

endmodule