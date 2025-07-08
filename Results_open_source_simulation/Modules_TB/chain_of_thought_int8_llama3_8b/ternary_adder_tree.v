module ternary_adder_tree_tb();

parameter WIDTH = 16;

reg [WIDTH-1:0] A, B, C, D, E;
reg CLK;

wire [WIDTH-1:0] OUT;

ternary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.CLK(CLK),.OUT(OUT));

initial begin
    #10; // delay for setup
    A = 8'hF; B = 8'h3; C = 8'h5; D = 8'h9; E = 8'hc;
    CLK = 1'b0;
    #20; // clock pulse
    CLK = 1'b1;
    #100; // wait for output stabilization
    $monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, OUT=%h", A, B, C, D, E, OUT);
    #10000; // run for 10ms
    $display("Simulation complete");
    $finish;
end

always #5 CLK = ~CLK; // clock generation

endmodule