module uart_module #(parameter BAUD_RATE = 9600)(clk, rst, rx, tx, data_in[7:0], data_out[7:0]);

reg [7:0] shift_reg;
reg [3:0] counter;
reg tx_en;

always @(posedge clk)
begin
    if (rst)
        shift_reg <= 'b0;
    else
        shift_reg <= {shift_reg[6:0], rx};
end

always @(posedge clk)
begin
    if (rst)
        counter <= 'd0;
    else
        counter <= counter + 1'b1;
end

always @(posedge clk)
begin
    if (counter == BAUD_RATE/16 - 1)
        counter <= 'd0;
    else
        counter <= counter + 1'b1;
end

assign tx = shift_reg[0];

always @(posedge clk)
begin
    if (rst || counter == BAUD_RATE/16 - 1)
        tx_en <= 'd0;
    else
        tx_en <= 'd1;
end

always @(posedge clk)
begin
    if (tx_en &&!tx)
        data_out <= shift_reg;
    else
        data_out <= data_out;
end

always @(posedge clk)
begin
    if (data_in!= 'h00)
        shift_reg <= {data_in, shift_reg[7:1]};
    else
        shift_reg <= shift_reg;
end

endmodule