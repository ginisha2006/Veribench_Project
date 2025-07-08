module tb_binary_adder_tree(
	input [15:0] A,
	input [15:0] B,
	input [15:0] C,
	input [15:0] D,
	input [15:0] E,
	input clk,
	output logic [15:0] out
);
	
	binary_adder_tree dut (
		.A(A),
		.B(B),
		.C(C),
		.D(D),
		.E(E),
		.clk(clk),
		.out(out)
	);
	
	logic [15:0] sum1, sum2, sum3, sum4;
	logic [15:0] sumreg1, sumreg2, sumreg3, sumreg4;
	
	always @(posedge clk) begin
		sumreg1 <= sum1;
		sumreg2 <= sum2;
		sumreg3 <= sum3;
		sumreg4 <= sum4;
	end
	
	assign sum1 = A + B;
	assign sum2 = C + D;
	assign sum3 = sumreg1 + sumreg2;
	assign sum4 = sumreg3 + E;
	
	property p_no_overflow;
		@(posedge clk)
		($unsigned(sum1) < 65536) |-> ($unsigned(sumreg1) == sum1);
		($unsigned(sum2) < 65536) |-> ($unsigned(sumreg2) == sum2);
		($unsigned(sum3) < 65536) |-> ($unsigned(sumreg3) == sum3);
		($unsigned(sum4) < 65536) |-> ($unsigned(sumreg4) == sum4);
	endproperty
	
	assert property(p_no_overflow);
	
	property p_correct_output;
		@(posedge clk)
		out == sumreg4;
	endproperty
	
	assert property(p_correct_output);
	
	property p_timing_constraints;
		@(posedge clk)
		($rose(sum1)) |=> ($stable(sumreg1));
		($rose(sum2)) |=> ($stable(sumreg2));
		($rose(sum3)) |=> ($stable(sumreg3));
		($rose(sum4)) |=> ($stable(sumreg4));
	endproperty
	
	assert property(p_timing_constraints);
	
endmodule