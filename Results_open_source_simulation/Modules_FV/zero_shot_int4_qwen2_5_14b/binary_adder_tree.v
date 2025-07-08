module tb_binary_adder_tree();

	logic [15:0] A, B, C, D, E;
	logic clk;
	logic [15:0] out;

	binary_adder_tree dut (
		.A(A),
		.B(B),
		.C(C),
		.D(D),
		.E(E),
		.clk(clk),
		.out(out)
	);

	always begin
		#5 clk = ~clk;
	end
	
	property no_overflow_underflow(input logic [15:0] a, b, output logic [15:0] sum);
		@(posedge clk) disable iff (!reset)
		($unsigned(a+b) > 65535 | $signed({{1'b0,a}}+{{1'b0,b}}) < -32768) |-> $rose(sum != a+b);
	endproperty
	
	assert property(no_overflow_underflow(A,B,sum1));
	assert property(no_overflow_underflow(C,D,sum2));
	assert property(no_overflow_underflow(sum1,sum2,sum3));
	assert property(no_overflow_underflow(sum3,E,out));

	property correct_sum(input logic [15:0] a, b, c, d, e, output logic [15:0] final_sum);
		@(posedge clk) disable iff (!reset)
		final_sum == a + b + c + d + e;
	endproperty
	
	assert property(correct_sum(A,B,C,D,E,out));

endmodule