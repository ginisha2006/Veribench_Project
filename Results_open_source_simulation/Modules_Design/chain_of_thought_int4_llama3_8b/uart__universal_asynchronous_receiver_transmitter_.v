module #(
    parameter BAUD_RATE = 9600
)
uart_module (
    input clk,
    input rst,
    input [7:0] rx,
    output tx,
    input [7:0] data_in,
    output [7:0] data_out
);

reg [3:0] baud_counter;
reg [7:0] shift_reg;

always @(posedge clk) begin
    if (rst) begin
        baud_counter <= 4'b0000;
        shift_reg <= 8'bx;
    end else begin
        baud_counter <= baud_counter + 1'b1;
        if (baud_counter == 4'b1111) begin
            baud_counter <= 4'b0000;
            shift_reg <= {rx, shift_reg[7:1]};
        end
    end
end

assign tx = ~shift_reg[0];
assign data_out = shift_reg;

endmodule