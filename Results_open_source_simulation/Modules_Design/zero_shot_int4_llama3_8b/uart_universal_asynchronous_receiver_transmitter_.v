module uart_module #(parameter BAUD_RATE = 9600);

input clk;
input rst;
input [7:0] data_in;
output [7:0] data_out;
output tx;

reg [3:0] state;
reg [7:0] rx_data;
reg [7:0] tx_data;
reg tx_en;
reg rx_en;
reg [2:0] baud_counter;
reg [2:0] bit_counter;

always @(posedge clk)
begin
    if (rst)
        state <= 4'b0000;
    else
    begin
        case (state)
            4'h0:
                begin
                    baud_counter <= 3'd0;
                    tx_en <= 1'b0;
                    rx_en <= 1'b0;
                end
            4'h1:
                begin
                    baud_counter <= baud_counter + 1'b1;
                    if (baud_counter == BAUD_RATE - 1)
                        state <= 4'h2;
                end
            4'h2:
                begin
                    baud_counter <= 3'd0;
                    tx_en <= ~tx_en;
                    rx_en <= ~rx_en;
                end
            4'h3:
                begin
                    baud_counter <= baud_counter + 1'b1;
                    if (baud_counter == BAUD_RATE - 1)
                        state <= 4'h0;
                end
            default: state <= 4'h0;
        endcase
    end

always @(posedge clk)
begin
    if (rx_en)
        rx_data <= data_in;
end

always @(posedge clk)
begin
    if (tx_en)
        tx <= tx_data;
end

always @(posedge clk)
begin
    if (~rst)
        tx_data <= data_in;
    else
        tx_data <= tx_data;
end

assign data_out = rx_data;
endmodule