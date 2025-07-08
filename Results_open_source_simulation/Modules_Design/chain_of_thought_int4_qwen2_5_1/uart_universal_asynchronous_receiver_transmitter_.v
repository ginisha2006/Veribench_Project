module uart_module #(
    parameter integer BAUD_RATE = 9600
)(
    input clk,
    input rst,
    input rx,
    output reg tx,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg [31:0] baud_counter;
reg [7:0] shift_reg;
reg [7:0] rx_data;
reg rx_state;
reg tx_state;

always @(posedge clk or posedge rst) begin
    if(rst)
        baud_counter <= 0;
    else
        baud_counter <= baud_counter + 1;
end

always @(posedge clk or posedge rst) begin
    if(rst || baud_counter == 8'd50_000_000/BAUD_RATE - 1)
        rx_state <= 1'b0;
    else if(rx)
        rx_state <= 1'b1;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        shift_reg <= 8'hFF;
    else if(baud_counter == 8'd50_000_000/BAUD_RATE - 1 && rx_state)
        shift_reg <= {shift_reg[6:0],rx};
end

always @(posedge clk or posedge rst) begin
    if(rst)
        data_out <= 8'hFF;
    else if(baud_counter == 8'd50_000_000/BAUD_RATE * 10)
        data_out <= shift_reg;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        tx_state <= 1'b0;
    else if(data_in != 8'hFF)
        tx_state <= 1'b1;
end

always @(posedge clk or posedge rst) begin
    if(rst)
        tx <= 1'b1;
    else if(tx_state)
        tx <= 1'b0;
    else if(baud_counter == 8'd50_000_000/BAUD_RATE * 10)
        tx <= 1'b1;
end

endmodule