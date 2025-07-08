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
wire baud_tick;

assign baud_tick = (baud_counter == ((50_000_000/BAUD_RATE)-1));

always @(posedge clk or posedge rst)
begin
    if(rst)
        baud_counter <= 0;
    else if(baud_counter < ((50_000_000/BAUD_RATE)-1))
        baud_counter <= baud_counter + 1;
    else
        baud_counter <= 0;
end

reg [7:0] shift_reg_rx;
reg [7:0] shift_reg_tx;
reg [3:0] bit_count_rx;
reg [3:0] bit_count_tx;
reg start_bit_rx;
reg stop_bit_rx;
reg start_bit_tx;
reg stop_bit_tx;
reg rx_done;
reg tx_done;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        shift_reg_rx <= 8'b0;
        bit_count_rx <= 4'b0;
        start_bit_rx <= 1'b0;
        stop_bit_rx <= 1'b0;
        rx_done <= 1'b0;
    end
    else if(!rx_done && !start_bit_rx && baud_tick)
    begin
        start_bit_rx <= ~rx; // Detect start bit
        if(start_bit_rx)
            bit_count_rx <= 4'd7;
    end
    else if(rx_done || start_bit_rx)
    begin
        if(bit_count_rx > 0)
            shift_reg_rx <= {shift_reg_rx[6:0], rx};
        bit_count_rx <= bit_count_rx - 1;
        if(bit_count_rx == 0)
            stop_bit_rx <= ~rx; // Detect stop bit
        if(stop_bit_rx)
            rx_done <= 1'b1;
    end
    else
    begin
        rx_done <= 1'b0;
        start_bit_rx <= 1'b0;
        stop_bit_rx <= 1'b0;
        bit_count_rx <= 4'b0;
    end
end

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        shift_reg_tx <= data_in;
        bit_count_tx <= 4'd8;
        start_bit_tx <= 1'b1;
        stop_bit_tx <= 1'b0;
        tx_done <= 1'b0;
    end
    else if(!tx_done && baud_tick)
    begin
        if(bit_count_tx > 0)
            tx <= shift_reg_tx[7];
        else
            tx <= 1'b1; // Send stop bit
        shift_reg_tx <= {shift_reg_tx[6:0], 1'b0};
        bit_count_tx <= bit_count_tx - 1;
        if(bit_count_tx == 0)
            tx_done <= 1'b1;
    end
    else if(tx_done)
    begin
        tx <= 1'b1;
        tx_done <= 1'b0;
        start_bit_tx <= 1'b0;
        stop_bit_tx <= 1'b0;
        bit_count_tx <= 4'd8;
    end
end

endmodule