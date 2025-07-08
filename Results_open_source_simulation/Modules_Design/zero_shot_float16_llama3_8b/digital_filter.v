module digital_filter(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    input wire [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

reg [DATA_WIDTH-1:0] acc;
reg [DATA_WIDTH-1:0] prev_data;

always @(posedge clk)
begin
    if (rst)
        acc <= 0;
    else
        acc <= acc + {data_in, ~data_in};
end

always @(posedge clk)
begin
    if (rst)
        prev_data <= 0;
    else
        prev_data <= data_in;
end

always @(posedge clk)
begin
    if (rst)
        data_out <= 0;
    else
        data_out <= acc + prev_data * coeff[0];
end

genvar i;
generate
    for (i = 1; i < NUM_TAPS; i = i + 1)
    begin : tap_loop
        always @(posedge clk)
        begin
            if (rst)
                data_out <= 0;
            else
                data_out <= data_out + prev_data * coeff[i];
        end
    end
endgenerate

endmodule