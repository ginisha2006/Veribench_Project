module digital_filter(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    input wire [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

reg [DATA_WIDTH-1:0] acc;
reg [DATA_WIDTH-1:0] prev_data;

always @(posedge clk) begin
    if (rst) begin
        acc <= 'd0;
        prev_data <= 'd0;
    end else begin
        acc <= {acc[DATA_WIDTH-2:0], data_in};
        data_out <= acc;
        for (genvar i = 0; i < NUM_TAPS; i++) begin
            acc <= acc - coeff[i] * prev_data;
        end
        prev_data <= data_in;
    end
end

endmodule