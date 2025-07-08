module uart_module #(parameter BAUD_RATE = 9600)(clk, rst, rx, tx, data_in[7:0], data_out[7:0]);

reg [3:0] bit_count;
reg [7:0] data_reg;
reg tx_en;

always @(posedge clk)
begin
    if (rst)
        bit_count <= 4'd0;
    else
        bit_count <= bit_count + 4'd1;
end

always @(posedge clk)
begin
    if (bit_count == 4'd11)
        data_reg <= data_in;
    bit_count <= bit_count + 4'd1;
end

always @(posedge clk)
begin
    if (rst || (tx_en && bit_count == 4'd8))
        tx <= 1'b0;
    else if (bit_count == 4'd16)
        tx <= ~tx;
end

always @(posedge clk)
begin
    if (rst)
        tx_en <= 1'b0;
    else if (bit_count == 4'd15)
        tx_en <= 1'b1;
end

assign data_out = data_reg;

endmodule