module uart_module #(parameter BAUD_RATE = 9600)(input wire clk, input wire rst, input wire [7:0] data_in, output reg [7:0] data_out, output wire tx, input wire rx);

reg [15:0] shift_reg;
reg [3:0] count;

always @(posedge clk)
begin
    if (rst) begin
        shift_reg <= 'bz;
        count <= 'd0;
    end else begin
        if (count == 11'd1125) // 16 bits per character * 10 characters per second at 9600 baud rate
            begin
                shift_reg <= {data_in, shift_reg[15:8]};
                count <= 'd0;
            end
        else
            count <= count + 1'b1;
    end
end

assign tx = shift_reg[7];

always @(posedge clk)
begin
    if (rst) begin
        data_out <= 'bz;
    end else begin
        if (rx &&!shift_reg[15]) begin
            data_out <= shift_reg[7:0];
        end
    end
end

endmodule