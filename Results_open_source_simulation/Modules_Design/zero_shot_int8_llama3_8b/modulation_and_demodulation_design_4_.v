module mod_demod #(parameter DATA_WIDTH = 16)
(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

reg [DATA_WIDTH-1:0] carrier;
reg [DATA_WIDTH-1:0] phase;

always @(posedge clk) begin
    if (rst) begin
        carrier <= 16'b0;
        phase <= 16'h0000;
    end else begin
        carrier <= carrier + 1;
        phase <= phase + 1;
    end
end

assign modulated_signal = carrier & data_in;

always @(posedge clk) begin
    if (rst) begin
        demodulated_data <= 16'b0;
    end else begin
        demodulated_data <= modulated_signal & carrier;
    end
end

endmodule