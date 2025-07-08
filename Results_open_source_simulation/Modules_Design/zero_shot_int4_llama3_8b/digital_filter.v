module digital_filter(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    input wire [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

reg [DATA_WIDTH-1:0] acc;
reg [COEFF_WIDTH-1:0] temp;

always @(posedge clk) begin
    if (rst) begin
        acc <= 0;
    end else begin
        acc <= {acc[DATA_WIDTH-2:0], data_in};
    end
end

always @(posedge clk) begin
    if (rst) begin
        temp <= 0;
    end else begin
        temp <= coeff[0];
    end
end

always @(posedge clk) begin
    if (rst) begin
        data_out <= 0;
    end else begin
        data_out <= acc;
    end
end

generate
for (genvar i = 1; i < NUM_TAPS; i++) begin
    always @(posedge clk) begin
        if (rst) begin
            temp <= 0;
        end else begin
            temp <= {temp[COEFF_WIDTH-2:0], coeff[i]};
        end
    end
end
endgenerate

always @(posedge clk) begin
    if (rst) begin
        acc <= 0;
    end else begin
        acc <= {acc[DATA_WIDTH-2:0], temp};
    end
end

endmodule