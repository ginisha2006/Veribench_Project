module uart_module #(parameter integer BAUD_RATE = 9600)(
    input clk,
    input rst,
    input rx,
    output reg tx,
    input [7:0] data_in,
    output reg [7:0] data_out
);
reg [31:0] baud_counter;
reg [7:0] shift_reg;
reg [2:0] bit_count;
reg rx_sampled;
reg tx_empty;

always @(posedge clk or posedge rst) begin
    if(rst)
        baud_counter <= 0;
    else
        baud_counter <= baud_counter + 1;
end

always @(posedge clk) begin
    if(baud_counter == ((50_000_000/BAUD_RATE)-1)) begin
        baud_counter <= 0;
        rx_sampled <= rx;
        if(bit_count == 4'd8) begin
            bit_count <= 0;
            data_out <= shift_reg;
        end else if(bit_count < 4'd8 && rx_sampled == 1'b0) begin
            shift_reg <= {shift_reg[6:0],rx_sampled};
            bit_count <= bit_count + 1;
        end
    end
end

always @(posedge clk) begin
    if(tx_empty == 1'b1 || tx == 1'b1) begin
        if(data_in != 8'hFF) begin
            tx_empty <= 1'b0;
            shift_reg <= {data_in,1'b0,1'b0,1'b0,1'b0};
            bit_count <= 4'd10;
        end
    end else if(bit_count > 4'd0) begin
        tx <= shift_reg[7];
        shift_reg <= {shift_reg[6:0],1'b0};
        bit_count <= bit_count - 1;
    end else begin
        tx <= 1'b1;
        tx_empty <= 1'b1;
    end
end
endmodule