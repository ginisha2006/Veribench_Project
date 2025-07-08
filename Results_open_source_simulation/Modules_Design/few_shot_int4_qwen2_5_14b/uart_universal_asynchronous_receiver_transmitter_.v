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
reg rx_ready;

always @(posedge clk or posedge rst)
begin
    if(rst)
        baud_counter <= 0;
    else
        baud_counter <= baud_counter + 1;
end

// UART receiver logic
always @(negedge clk or posedge rst)
begin
    if(rst)
        rx_data <= 0;
    else if(baud_counter == BAUD_RATE - 1)
    begin
        if(rx)
            rx_data <= {rx_data[6:0], 1'b0};
        else
            rx_data <= {rx_data[6:0], 1'b1};

        if(baud_counter == BAUD_RATE * 10 && !rx)
            rx_ready <= 1;
    end
end

assign data_out = rx_ready ? rx_data : 8'hFF; // FF as default value when not ready

// UART transmitter logic
always @(posedge clk or posedge rst)
begin
    if(rst || tx)
        shift_reg <= 0;
    else if(!tx && baud_counter == BAUD_RATE - 1)
        shift_reg <= {shift_reg[6:0], 1'b0};

    if(shift_reg == 0)
        tx <= 1;
    else if(shift_reg == 8'd255)
        tx <= 0;
end

always @(posedge clk or posedge rst)
begin
    if(rst)
        shift_reg <= 0;
    else if(tx && shift_reg == 0)
        shift_reg <= data_in;
end

endmodule