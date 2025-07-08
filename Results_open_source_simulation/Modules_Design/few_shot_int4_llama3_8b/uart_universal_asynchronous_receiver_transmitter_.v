module uart_module #(parameter BAUD_RATE = 9600) (
    input clk,
    input rst,
    input [7:0] rx,
    output tx,
    input [7:0] data_in,
    output [7:0] data_out
);
    reg [3:0] state;
    reg [7:0] rx_data;
    reg [7:0] tx_data;
    reg tx_en;

    always @(posedge clk)
        if (rst) begin
            state <= 4'b0000;
            rx_data <= 8'bx;
            tx_data <= 8'bx;
            tx_en <= 1'b0;
        end else begin
            case (state)
                4'h0: begin
                    if (~tx_en && ~rx) state <= 4'h1;
                end
                4'h1: begin
                    if (rx) state <= 4'h2;
                end
                4'h2: begin
                    if (~rx) state <= 4'h3;
                end
                4'h3: begin
                    if (~tx_en) state <= 4'h0;
                end
                default: state <= 4'h0;
            endcase
        end

    assign tx = tx_data;
    assign data_out = rx_data;
    assign tx_en = (state == 4'h3);

    always @(posedge clk)
        if (state == 4'h2) rx_data <= rx;

    always @(posedge clk)
        if (state == 4'h3) tx_data <= data_in;
endmodule