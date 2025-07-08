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

reg [DATA_WIDTH-1:0] delay_line [0:NUM_TAPS-1];
integer i;

always @(posedge clk or posedge rst)
begin
    if(rst)
        for(i = 0; i < NUM_TAPS; i = i + 1)
            delay_line[i] <= 0;
    else
    begin
        delay_line[0] <= data_in;
        for(i = 1; i < NUM_TAPS; i = i + 1)
            delay_line[i] <= delay_line[i-1];
    end
end

always @* begin
    data_out = 0;
    for(i = 0; i < NUM_TAPS; i = i + 1)
        data_out = data_out + ({DATA_WIDTH{delay_line[i][DATA_WIDTH-1]}} & {delay_line[i]} * coeff[i]);
end

endmodule