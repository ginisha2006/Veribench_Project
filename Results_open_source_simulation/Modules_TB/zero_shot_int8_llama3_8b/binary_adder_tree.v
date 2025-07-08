module binary_adder_tree_tb();

parameter WIDTH = 16;

reg [WIDTH-1:0] A, B, C, D, E;
reg clk;
wire [WIDTH-1:0] out;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

initial begin
	#20 clk = 1'b0; // reset
	A = 12'h0008; B = 12'h0010; C = 12'h0020; D = 12'h0030; E = 12'h0040;
	#100 clk = 1'b1; // clock pulse
	@(posedge clk);
	$display("Expected out: %h", 24'h0080); // expected result
	$monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	repeat(5) @(posedge clk);
	A = 12'h8000; B = 12'h0001; C = 12'h0002; D = 12'h0003; E = 12'h0004;
	#100 clk = 1'b1; // clock pulse
	@(posedge clk);
	$display("Expected out: %h", 24'h8019); // expected result
	$monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	repeat(5) @(posedge clk);
	#100 $stop;
end

endmodule