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

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        tx <= 1'b1;
        shift_reg <= 8'hFF;
    end
    else if(baud_counter == ((50_000_000/BAUD_RATE)-1))
    begin
        baud_counter <= 0;
        if(shift_reg != 8'hFF)
            tx <= shift_reg[0];
        shift_reg <= {shift_reg[6:0], 1'b0};
        if(shift_reg == 8'h00)
            tx <= 1'b1;
    end
end

always @(negedge clk or posedge rst)
begin
    if(rst)
    begin
        rx_data <= 8'h00;
        rx_ready <= 1'b0;
    end
    else if(rx == 1'b0 && !rx_ready)
    begin
        rx_ready <= 1'b1;
        baud_counter <= 0;
    end
    else if(rx_ready && baud_counter == ((50_000_000/BAUD_RATE)/10))
    begin
        rx_data <= {rx_data[6:0], rx};
        baud_counter <= 0;
        if(!baud_counter)
            rx_ready <= 1'b0;
    end
end

assign data_out = rx_data;

endmodule