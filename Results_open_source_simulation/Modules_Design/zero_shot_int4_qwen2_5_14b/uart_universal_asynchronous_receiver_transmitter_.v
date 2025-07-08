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
reg [2:0] bit_count;

always @(posedge clk or posedge rst) begin
    if(rst)
        baud_counter <= 0;
    else
        baud_counter <= baud_counter + 1;
end

always @(posedge clk or posedge rst) begin
    if(rst || baud_counter == 48000000/BAUD_RATE - 1)
        baud_counter <= 0;
    else if(baud_counter == 48000000/BAUD_RATE - 1 && !tx)
        tx <= 1'b1;
end

always @(negedge clk or posedge rst) begin
    if(rst)
        {shift_reg, tx} <= 8'b1111_1111;
    else if(!tx && baud_counter == 48000000/BAUD_RATE - 1)
        case(bit_count)
            3'd0 : {shift_reg, tx} <= {data_in, 1'b0};
            default : {shift_reg, tx} <= {shift_reg[6:0], tx};
        endcase
end

always @(negedge clk or posedge rst) begin
    if(rst)
        bit_count <= 3'd0;
    else if(!tx && baud_counter == 48000000/BAUD_RATE - 1)
        bit_count <= bit_count + 1;
end

always @(negedge clk or posedge rst) begin
    if(rst)
        data_out <= 8'b0;
    else if(rx && baud_counter == 48000000/BAUD_RATE - 1)
        data_out <= shift_reg;
end

endmodule