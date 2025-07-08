module digital_filter #(
    parameter int DATA_WIDTH = 16,
    parameter int COEFF_WIDTH = 16,
    parameter int NUM_TAPS = 32
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    input [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

reg [DATA_WIDTH-1:0] delay_line[NUM_TAPS];
reg [DATA_WIDTH+COEFF_WIDTH-1:0] product[NUM_TAPS];

always @(posedge clk or posedge rst)
begin
    if(rst)
        for(int i=0; i<NUM_TAPS; i=i+1)
            delay_line[i] <= 'b0;
    else
        begin
            delay_line[0] <= data_in;
            for(int i=0; i<NUM_TAPS-1; i=i+1)
                delay_line[i+1] <= delay_line[i];
        end
end

always @*
begin
    for(int i=0; i<NUM_TAPS; i=i+1)
        product[i] = delay_line[i] * coeff[i];
end

assign data_out = sum(product);

endmodule