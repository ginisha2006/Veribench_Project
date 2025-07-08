module digital_filter #(
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter NUM_TAPS = 32
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    input [NUM_TAP_S-1:0][COEFF_WIDTH-1:0] coeff
);
reg [DATA_WIDTH-1:0] delayed_data[NUM_TAPS];
always @(posedge clk) begin
    if(rst)
        for(int i=0; i<NUM_TAPS; i++)
            delayed_data[i] <= 0;
    else begin
        for(int i=0; i<NUM_TAPS-1; i=i+1)
            delayed_data[i] <= delayed_data[i+1];
        delayed_data[NUM_TAPS-1] <= data_in;
    end
end

always @(posedge clk) begin
    if(!rst)
        data_out <= 0;
    else begin
        data_out <= 0;
        for(int i=0; i<NUM_TAPS; i=i+1)
            data_out <= data_out + (delayed_data[i]*coeff[i]);
    end
end
endmodule