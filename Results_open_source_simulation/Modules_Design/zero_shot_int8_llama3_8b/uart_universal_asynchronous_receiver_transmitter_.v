module uart_module #(parameter BAUD_RATE = 9600)(input wire clk, input wire rst, input wire [7:0] data_in, output reg [7:0] data_out, output reg tx);

reg [3:0] bit_counter;
reg [2:0] state;

always @(posedge clk)
begin
    if (rst) begin
        bit_counter <= 4'd0;
        state <= 3'b000;
    end else begin
        case (state)
            3'b000: begin
                if (bit_counter == 4'd16) begin
                    bit_counter <= 4'd0;
                    state <= 3'b001;
                end else begin
                    bit_counter <= bit_counter + 4'd1;
                end
            end
            3'b001: begin
                if (bit_counter == 4'd8) begin
                    bit_counter <= 4'd0;
                    state <= 3'b010;
                end else begin
                    bit_counter <= bit_counter + 4'd1;
                end
            end
            3'b010: begin
                data_out <= data_in;
                state <= 3'b011;
            end
            3'b011: begin
                if (bit_counter == 4'd8) begin
                    bit_counter <= 4'd0;
                    state <= 3'b100;
                end else begin
                    bit_counter <= bit_counter + 4'd1;
                end
            end
            3'b100: begin
                if (bit_counter == 4'd5) begin
                    bit_counter <= 4'd0;
                    state <= 3'b101;
                end else begin
                    bit_counter <= bit_counter + 4'd1;
                end
            end
            3'b101: begin
                if (bit_counter == 4'd8) begin
                    bit_counter <= 4'd0;
                    state <= 3'b110;
                end else begin
                    bit_counter <= bit_counter + 4'd1;
                end
            end
            3'b110: begin
                if (bit_counter == 4'd5) begin
                    bit_counter <= 4'd0;
                    state <= 3'b111;
                end else begin
                    bit_counter <= bit_counter + 4'd1;
                end
            end
            3'b111: begin
                if (bit_counter == 4'd8) begin
                    bit_counter <= 4'd0;
                    state <= 3'b000;
                end else begin
                    bit_counter <= bit_counter + 4'd1;
                end
            end
        endcase
    end
end

assign tx = (state == 3'b010 || state == 3'b110)? data_in[0] : 1'b0;

endmodule