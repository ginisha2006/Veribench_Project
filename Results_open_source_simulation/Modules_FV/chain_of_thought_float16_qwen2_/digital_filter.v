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
    clk = 1'b0;
    #(5ns) clk = 1'b1;
    #(5ns)
end

property reset_assertion;
    @(posedge clk) disable iff (!rst) data_out == 16'd0;
endproperty
assert property(reset_assertion);

property stable_output_when_reset;
    @(posedge clk) disable iff (!rst) data_out[*] |-> data_out[*] == data_out[0];
endproperty
assert property(stable_output_when_reset);

property no_change_on_invalid_coefficients;
    @(posedge clk) disable iff (!rst) coeff[*][*] |-> data_out[*] == data_out[0];
endproperty
assert property(no_change_on_invalid_coefficients);

property output_within_data_width_bounds;
    @(posedge clk) disable iff (!rst) data_out inside {[0 : 65535]};
endproperty
assert property(output_within_data_width_bounds);

property no_negative_values_if_positive_input_and_coefficients;
    @(posedge clk) disable iff (!rst && &{coeff[*]} && data_in > 0) data_out >= 0;
endproperty
assert property(no_negative_values_if_positive_input_and_coefficients);

property no_overflow_with_max_coeffs_and_inputs;
    @(posedge clk) disable iff (!rst && &{coeff[*]} && data_in == 16'hFFFF) data_out <= 16'hFFFF;
endproperty
assert property(no_overflow_with_max_coeffs_and_inputs);

property no_underflow_with_min_coeffs_and_inputs;
    @(posedge clk) disable iff (!rst && {coeff[*]} == 16'h0000 && data_in == 16'h0000) data_out >= 0;
endproperty
assert property(no_underflow_with_min_coeffs_and_inputs);

endmodule