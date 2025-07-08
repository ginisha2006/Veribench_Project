module digital_filter #(
    parameter int DATA_WIDTH = 16,
    parameter int COEFF_WIDTH = 16,
    parameter int NUM_TAPS = 32
)(
    input logic clk,
    input logic rst,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out,
    input logic [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

logic [DATA_WIDTH-1:0] taps[NUM_TAPS];
always_ff @(posedge clk or posedge rst)
begin
    if(rst)
        for(int i=0; i<NUM_TAPs; i++)
            taps[i] <= '0;
    else
        begin
            taps[0] <= data_in;
            for(int i=1; i<NUM_TAPS; i++)
                taps[i] <= taps[i-1];
        end
end

assign data_out = sum(taps[i]*coeff[i] for(i=0;i<NUM_TAPS;i));

endmodule