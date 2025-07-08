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
    #100 clk = 0; // Initialize clock
    forever begin
        #5 clk = ~clk; // Toggle clock
    end
end

integer i;
initial begin
    for (i=0; i<4; i=i+1) begin
        A = $random % (1 << WIDTH); // Randomize input A
        B = $random % (1 << WIDTH); // Randomize input B
        C = $random % (1 << WIDTH); // Randomize input C
        D = $random % (1 << WIDTH); // Randomize input D
        E = $random % (1 << WIDTH); // Randomize input E
        #20; // Wait for clock cycle
    end
    $display("Test complete");
end

$monitor($time, "A=%h, B=%h, C=%h, D=%h, E=%h, OUT=%h", A, B, C, D, E, OUT);

endmodule