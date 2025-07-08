module mod_demod #(parameter DATA_WIDTH=16) (
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output [DATA_WIDTH-1:0] modulated_signal,
    output [DATA_WIDTH-1:0] demodulated_data
);
    reg [DATA_WIDTH-1:0] carrier = 1 << (DATA_WIDTH-1);
    always @(posedge clk) begin
        if (rst) begin
            modulated_signal <= 0;
            demodulated_data <= 0;
        end else begin
            modulated_signal <= data_in * carrier;
            demodulated_data <= modulated_signal / carrier;
        end
    end
endmodule