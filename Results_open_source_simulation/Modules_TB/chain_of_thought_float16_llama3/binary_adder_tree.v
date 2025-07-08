module binary_adder_tree_tb();

parameter WIDTH = 16;

reg [WIDTH-1:0] A, B, C, D, E;
reg clk;
wire [WIDTH-1:0] out;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

initial begin
	#10 clk = 0; // reset
	#20 clk = 1; // clock high
	#40 $monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, out=%h", A, B, C, D, E, out);
	
	A = 8'h0001; B = 8'h0002; C = 8'h0003; D = 8'h0004; E = 8'h0005;
	#100 A = 8'h0010; B = 8'h0006; C = 8'h0007; D = 8'h0008; E = 8'h0009;
	#100 A = 8'hz000; B = 8'h000a; C = 8'h000b; D = 8'h000c; E = 8'h000d;
	#100 $stop;
end

always #5 clk = ~clk; // clock generation

endmodule