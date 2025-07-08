module uart_module #(
    parameter BAUD_RATE = 9600
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
    if(rst) begin
        shift_reg <= 8'b0;
        tx <= 1'b1;
        tx_state <= 1'b0;
    end else if(tx_state == 1'b0 && baud_counter >= ((50_000_000/BAUD_RATE)-1)) begin
        tx <= ~data_in[0];
        shift_reg <= {data_in[6:0],1'b0};
        tx_state <= 1'b1;
    end else if(tx_state == 1'b1 && baud_counter >= ((50_000_000/(BAUD_RATE*10))-1)) begin
        tx <= shift_reg[7];
        shift_reg <= {shift_reg[6:0],1'b0};
        if(shift_reg == 8'b0)
            tx_state <= 1'b0;
    end
end

always @(negedge clk or posedge rst) begin
    if(rst || baud_counter < ((50_000_000/BAUD_RATE)-1))
        rx_state <= 1'b0;
    else if(rx_state == 1'b0 && baud_counter >= ((50_000_000/BAUD_RATE)-1)) begin
        rx_state <= 1'b1;
        rx_data <= 8'hFF;
    end else if(rx_state == 1'b1 && baud_counter >= (((50_000_000/BAUD_RATE)*10)-1)) begin
        rx_data <= {rx_data[6:0],rx};
        if(baud_counter >= (((50_000_000/BAUD_RATE)*11)-1)) begin
            data_out <= rx_data;
            rx_state <= 1'b0;
        end
    end
end

endmodule