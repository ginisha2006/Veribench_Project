module mod_demod #(
    parameter DATA_WIDTH = 16
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

reg [DATA_WIDTH-1:0] shift_reg;
always @(posedge clk or posedge rst)
begin
    if(rst)
        shift_reg <= 0;
    else
        shift_reg <= data_in;
end

// Modulation process
assign modulated_signal = {shift_reg[DATA_WIDTH-2:0], ~shift_reg[DATA_WIDTH-1]};

// Demodulation process
always @(posedge clk or posedge rst)
begin
    if(rst)
        demodulated_data <= 0;
    else
        demodulated_data <= modulated_signal ^ {modulated_signal[DATA_WIDTH-2:0], 1'b0};
end

endmodule