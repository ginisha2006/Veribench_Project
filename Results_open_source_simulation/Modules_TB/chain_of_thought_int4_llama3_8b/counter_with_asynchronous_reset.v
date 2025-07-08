module tb_counter;

parameter PERIOD = 10; // Clock period in ns

reg clk;
reg reset;
reg ena;
wire [7:0] result;

counter dut (
	.clk(clk),
	.reset(reset),
	.result(result),
	.ena(ena)
);

initial begin
	$monitor($time, "result: %b", result);
	#PERIOD * 5; // Wait for clock cycles
	$display("Initial value: %d", result); // Initial value should be 0
	#PERIOD; // Wait for one clock cycle
	ena = 1; // Enable counter
	#PERIOD * 4; // Count for 4 cycles
	$display("Counted value: %d", result); // Expected value is 4
	#PERIOD; // Wait for one clock cycle
	ena = 0; // Disable counter
	#PERIOD * 3; // Wait for 3 more clock cycles
	$display("Disabled value: %d", result); // Expected value is 4
	#PERIOD * 5; // Wait for clock cycles
	reset = 1; // Reset counter
	#PERIOD; // Wait for one clock cycle
	$display("Reset value: %d", result); // Expected value is 0
	#PERIOD * 5; // Wait for clock cycles
	reset = 0; // Release reset
	#PERIOD * 10; // Wait for clock cycles
	$display("Final value: %d", result); // Final value should be 0
end

initial begin
	clk = 0;
	forever #PERIOD clk = ~clk;
end

endmodule