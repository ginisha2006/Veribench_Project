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

reg [DATA_WIDTH-1:0] acc;

always @(posedge clk or posedge rst)
begin
    if(rst)
        acc <= 0;
    else
        begin
            acc <= 0;
            for(int i = 0; i < NUM_TAPS; i++)
                acc <= acc + (data_in * coeff[i]);
        end
end

assign data_out = acc;

endmodule