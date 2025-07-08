module tb_digital_filter (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] data_out,
    input [15:0] coeff [31:0]
);

reg clk;
wire rst;
wire [15:0] data_in;
wire [15:0] data_out;

digital_filter #(.DATA_WIDTH(16), .COEFF_WIDTH(16), .NUM_TAPS(32)) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
);

always begin
    clk <= ~clk; 
    #(5ns); 
end

property reset_assertion;
    @(posedge rst) disable iff (!rst)
        data_out == 0;
endproperty

assert property(reset_assertion);

property no_negative_data_out;
    @(posedge clk) disable iff (!rst)
        data_out >= 0;
endproperty

assert property(no_negative_data_out);

property no_positive_overflow;
    @(posedge clk) disable iff (!rst)
        data_out < 2**$bits(data_out);
endproperty

assert property(no_positive_overflow);

property stable_on_reset;
    @(posedge rst) disable iff (!rst)
        $stable(data_out);
endproperty

assert property(stable_on_reset);

property no_unexpected_changes;
    @(posedge clk) disable iff (!rst)
        !$isunknown(data_out);
endproperty

assert property(no_unexpected_changes);

endmodule