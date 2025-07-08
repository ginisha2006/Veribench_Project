module ternary_adder_tree_tb();

  reg [15:0] A, B, C, D, E;
  reg CLK;
  wire [15:0] OUT;

  ternary_adder_tree dut (
    .A(A), .B(B), .C(C), .D(D), .E(E), .CLK(CLK), .OUT(OUT)
  );

  initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
  end

  initial begin
    A = 8'b0000000000000000;
    B = 8'b1111111111111111;
    C = 8'b0000000000000001;
    D = 8'b1010101010101010;
    E = 8'b0101010101010101;
    #100;
    $monitor("A=%h B=%h C=%h D=%h E=%h CLK=%b OUT=%h", A, B, C, D, E, CLK, OUT);
    A = 8'b1010101010101010;
    B = 8'b0101010101010101;
    C = 8'b1111111111111111;
    D = 8'b0000000000000000;
    E = 8'b0000000000000000;
    #100;
    $monitor("A=%h B=%h C=%h D=%h E=%h CLK=%b OUT=%h", A, B, C, D, E, CLK, OUT);
    A = 8'b0000000000000000;
    B = 8'b0000000000000000;
    C = 8'b0000000000000000;
    D = 8'b0000000000000000;
    E = 8'b0000000000000000;
    #100;
    $monitor("A=%h B=%h C=%h D=%h E=%h CLK=%b OUT=%h", A, B, C, D, E, CLK, OUT);
  end

endmodule