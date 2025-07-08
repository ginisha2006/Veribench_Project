module tb_binary_adder_tree();

parameter CLOCK_PERIOD = 10;

input wire clk;

reg [15:0] A, B, C, D, E;

wire [15:0] out;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

always @(*) begin assert (@(posedge clk) disable iff (!clk) ($distinctsum(A, B) == sum1)); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ($distinctsum(C, D) == sum2)); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ($distinctsum(sum1, sum2) == sum3)); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ($distinctsum(sum3, E) == sum4)); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ($distinctsum(sum4) == out)); end

initial begin
#((CLOCK_PERIOD / 2) - 1) clk = 0;
#CLOCK_PERIOD clk = 1;
repeat(100) #CLOCK_PERIOD clk =!clk;
$stop;
end

endmodule