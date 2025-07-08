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

assert (@(posedge rst) disable iff (!rst)
        data_out == 0);

assert (@(posedge clk) disable iff (!rst)
        data_out >= 0);

assert (@(posedge clk) disable iff (!rst)
        data_out < 2**$bits(data_out));

assert (@(posedge rst) disable iff (!rst)
        $stable(data_out));

assert (@(posedge clk) disable iff (!rst)
        !$isunknown(data_out));

endmodule