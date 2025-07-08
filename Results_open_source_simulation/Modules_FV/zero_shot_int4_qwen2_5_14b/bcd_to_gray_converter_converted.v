module tb_bcd_to_gray (
    input clk,
    input [3:0] bcd,
    output reg [3:1] gray
);

wire [3:0] bcd_wire;
assign bcd_wire = bcd;

bcd_to_gray #(.BCD_WIDTH(4), .GRAY_WIDTH(4)) dut (
    .bcd(bcd_wire),
    .gray(gray)
);

property prop_no_overflow_underflow(input [3:0] bcd, output [3:0] gray);
    @(posedge clk) disable iff (!reset)
        !($unsigned({bcd[3],bcd}) > 9 || $unsigned({bcd[3],bcd[2:1]}) > 9 || $unsigned({bcd[3],bcd[2:0]}) > 9 || $unsigned({bcd[3],bcd[2:0],bcd[0]}) > 9);
endproperty

assert property(prop_no_overflow_underflow(bcd_wire, gray));

property prop_functional_correctness(input [3:0] bcd, output [3:0] gray);
    @(posedge clk) disable iff (!reset)
        gray == (bcd ^ (bcd >> 1));
endproperty

assert property(prop_functional_correctness(bcd_wire, gray));

assert (@(posedge clk) disable iff (!reset)
        reset ##1 gray == 4'b0);

always begin
    #(5ns); // Arbitrary period for clock generation
    clk = ~clk;
end

endmodule