module digital_filter #(
    parameter int DATA_WIDTH = 16,
    parameter int COEFF_WIDTH = 16,
    parameter int NUM_TAPS = 32
)(
    input logic clk,
    input logic rst,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [DATA_WIDTH-1:0] data_out,
    input logic [NUM_Taps-1:0][COEFF_WIDTH-1:0] coeff
);

logic [DATA_WIDTH-1:0] product[NUM_TAPS];
logic [DATA_WIDTH*2-1:0] sum;

always_ff @(posedge clk) begin
    if(rst)
        sum <= 'd0;
    else begin
        for(int i=0; i<NUM_TAPS; i++) 
            product[i] <= data_in * coeff[i];
        
        sum <= 'd0;
        for(int i=0; i<NUM_TAPS; i++)
            sum <= sum + product[i];
    
        data_out <= sum[DATA_WIDTH-1:0];
    end
end

endmodule