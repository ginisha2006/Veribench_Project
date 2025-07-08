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

reg [DATA_WIDTH-1:0] buffer [0:NUM_TAPS-1];
wire [DATA_WIDTH+COEFF_WIDTH-1:0] product [0:NUM_TAPS-1];

always @(posedge clk or posedge rst)
begin
    if(rst)
        for(int i=0; i<NUM_TAPS; i=i+1)
            buffer[i] <= 0;
    else
    begin
        buffer[0] <= data_in;
        for(int i=0; i<NUM_TAPS-1; i=i+1)
            buffer[i+1] <= buffer[i];
    end
end

generate
    genvar i;
    for(i=0; i<NUM_TAPS; i=i+1)
    begin : prod_gen
        assign product[i] = $signed(buffer[i]) * $signed(coeff[i]);
    end
endgenerate

assign data_out = ($signed({{COEFF_WIDTH{1'b0}},data_in}) - 
                   ({<<{product[NUM_TAPS-1:0]}}[DATA_WIDTH+COEFF_WIDTH-1:COEFF_WIDTH]))[DATA_WIDTH-1:0];

endmodule