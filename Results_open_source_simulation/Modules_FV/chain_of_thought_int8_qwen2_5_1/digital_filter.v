module tb_digital_filter (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] data_out,
    input [15:0] coeff [31:0]
);

wire clk;
reg rst;
reg [15:0] data_in;
wire [15:0] data_out;
reg [15:0] coeff [31:0];

digital_filter #(.DATA_WIDTH(16), .COEFF_WIDTH(16), .NUM_TAPS(32)) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
);

always begin
    clk = 1; #5; clk = 0; #5;
end

property reset_assertion;
    @(posedge clk) disable iff (!rst) data_out == 16'b0;
endproperty
assert property(reset_assertion);

property stable_output_when_reset;
    @(posedge clk) disable iff (!rst) $stable(data_out);
endproperty
assert property(stable_output_when_reset);

property non_negative_data_in;
    @(posedge clk) data_in >= 0;
endproperty
assert property(non_negative_data_in);

property non_negative_coefficients;
    @(posedge clk) coeff[0] >= 0;
    @(posedge clk) coeff[1] >= 0;
    @(posedge clk) coeff[2] >= 0;
    @(posedge clk) coeff[3] >= 0;
    @(posedge clk) coeff[4] >= 0;
    @(posedge clk) coeff[5] >= 0;
    @(posedge clk) coeff[6] >= 0;
    @(posedge clk) coeff[7] >= 0;
    @(posedge clk) coeff[8] >= 0;
    @(posedge clk) coeff[9] >= 0;
    @(posedge clk) coeff[10] >= 0;
    @(posedge clk) coeff[11] >= 0;
    @(posedge clk) coeff[12] >= 0;
    @(posedge clk) coeff[13] >= 0;
    @(posedge clk) coeff[14] >= 0;
    @(posedge clk) coeff[15] >= 0;
    @(posedge clk) coeff[16] >= 0;
    @(posedge clk) coeff[17] >= 0;
    @(posedge clk) coeff[18] >= 0;
    @(posedge clk) coeff[19] >= 0;
    @(posedge clk) coeff[20] >= 0;
    @(posedge clk) coeff[21] >= 0;
    @(posedge clk) coeff[22] >= 0;
    @(posedge clk) coeff[23] >= 0;
    @(posedge clk) coeff[24] >= 0;
    @(posedge clk) coeff[25] >= 0;
    @(posedge clk) coeff[26] >= 0;
    @(posedge clk) coeff[27] >= 0;
    @(posedge clk) coeff[28] >= 0;
    @(posedge clk) coeff[29] >= 0;
    @(posedge clk) coeff[30] >= 0;
    @(posedge clk) coeff[31] >= 0;
endproperty
assert property(non_negative_coefficients);

property no_overflow;
    @(posedge clk) disable iff (!rst) data_out <= 16'd65535;
endproperty
assert property(no_overflow);

property no_underflow;
    @(posedge clk) disable iff (!rst) data_out >= 16'd0;
endproperty
assert property(no_underflow);

endmodule