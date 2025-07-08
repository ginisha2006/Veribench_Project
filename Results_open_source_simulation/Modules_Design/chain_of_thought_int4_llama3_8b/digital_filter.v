module digital_filter(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    input wire [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

reg [DATA_WIDTH-1:0] acc;
reg [COEFF_WIDTH-1:0] tap;

always @(posedge clk) begin
    if (rst) begin
        acc <= 'b0;
    end else begin
        acc <= acc << 1;
        if (acc >= (1 << COEFF_WIDTH)) begin
            acc = acc >> 1;
        end
        for (int i = 0; i < NUM_TAPS; i++) begin
            if (i == 0) begin
                tap = coeff[i];
            end else begin
                tap = {tap[COEFF_WIDTH-2:0], 1'b0};
            end
            acc = acc + tap;
        end
        data_out <= acc[DATA_WIDTH-1:0];
    end
end

endmodule