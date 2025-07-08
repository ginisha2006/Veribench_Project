module gray_count_tb();

reg clk, enable, reset;
wire [7:0] gray_count;

gray_count uut (
	.clk(clk),
	.enable(enable),
	.reset(reset),
	.gray_count(gray_count)
);

initial begin
	#10 clk = 0; enable = 0; reset = 1; // Reset sequence
	#20 reset = 0; // Deassert reset
	#50 enable = 1; // Enable counter
	#200 enable = 0; // Disable counter
	#500 $display("Gray count: %b", gray_count); // Display final count
	$stop;
end

always #5 clk = ~clk; // Clock generation

endmodule