module tb_digital_filter (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] data_out,
    input [15:0] coeff [31:0]
);

reg clk;
wire [15:0] data_out;

digital_filter #(.DATA_WIDTH(16), .COEFF_WIDTH(16), .NUM_TAPS(32)) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
);

always #5 clk = ~clk;

property reset_assertion;
    @(posedge clk) disable iff (!rst) data_out == 16'b0;
endproperty
assert property(reset_assertion);

property stable_when_reset;
    @(posedge clk) disable iff (!rst) data_out[*] |-> data_out[*];
endproperty
assert property(stable_when_reset);

property no_negative_output;
    @(posedge clk) data_out >= 0;
endproperty
assert property(no_negative_output);

property no_positive_overflow;
    @(posedge clk) data_out <= 16'd65535;
endproperty
assert property(no_positive_overflow);

property coeff_range;
    foreach(coeff[i]) coeff[i][15:0] inside {[0 : 65535]};
endproperty
assert property(coeff_range);

property data_in_range;
    data_in[15:0] inside {[0 : 65535]};
endproperty
assert property(data_in_range);

endmodule