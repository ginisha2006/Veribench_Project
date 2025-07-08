module ternary_adder_tree_tb();

parameter WIDTH = 16;

reg clk;
wire [WIDTH-1:0] A, B, C, D, E, OUT;

ternary_adder_tree uut (
   .A(A),
   .B(B),
   .C(C),
   .D(D),
   .E(E),
   .CLK(clk),
   .OUT(OUT)
);

initial begin
    #100 clk = 0; // reset
    repeat (5) @(posedge clk); // wait for clock cycles
    A = 8'h0001; B = 8'h0002; C = 8'h0003; D = 8'h0004; E = 8'h0005;
    @(posedge clk);
    $monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, OUT=%h", A, B, C, D, E, OUT);
    repeat (5) @(posedge clk);
    A = 8'hz'zzzz; B = 8'hz'zzzy; C = 8'hz'zzzx; D = 8'hz'zzyy; E = 8'hz'zzyx;
    @(posedge clk);
    $monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, OUT=%h", A, B, C, D, E, OUT);
    repeat (5) @(posedge clk);
    A = 8'hff00; B = 8'h00ff; C = 8'h0f0f; D = 8'hf0f0; E = 8'hffff;
    @(posedge clk);
    $monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, OUT=%h", A, B, C, D, E, OUT);
    repeat (5) @(posedge clk);
    $finish;
end

always #10 clk =~ clk; // clock generation

endmodule