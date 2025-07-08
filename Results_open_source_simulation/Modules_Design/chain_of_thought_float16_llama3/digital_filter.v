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
        acc <= 'b0;
        prev_data <= 'b0;
    end else begin
        acc <= acc + {data_in, ^prev_data};
        prev_data <= data_in;
    end
end

assign data_out = acc[NUM_TAPS-1 -: DATA_WIDTH];

always @(coeff) begin
    assign acc = 'b0;
    assign prev_data = 'b0;
end

endmodule