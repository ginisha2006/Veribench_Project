module tb_single_port_ram;
// Input signals
reg [7:0] data;
reg [5:0] addr;
reg we;
reg clk;
// Output signal
wire [7:0] q;
// Initialize the RAM
reg [7:0] ram[63:0];
integer i;
initial begin
	for (i=0; i<64; i=i+1) begin
		ram[i] = 0;
	end
end
// Clock generation
reg clk_en = 0;
always #5 clk_en = ~clk_en;
assign clk = clk_en;
// Stimulus
initial begin
	// Display the header for the output
	$display("Time	data	addr	we	q");
	// Monitor changes to inputs and outputs
	$monitor("%0d	%b	%b	%b	%b", $time, data, addr, we, q);
	// Test Case 1: Write and read
	clk = 0; addr = 0; data = 8'hAA; we = 1; #20;
	clk = 0; addr = 0; we = 0; #20;
	clk = 1; #10;
	clk = 0; addr = 0; #10;
	clk = 1; #10;
	clk = 0; addr = 1; #10;
	clk = 1; #10;
	clk = 0; addr = 1; #10;
	clk = 1; #10;
	// Finish the simulation
	$finish;
end
endmodule