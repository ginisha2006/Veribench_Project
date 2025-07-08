module ternary_adder_tree_tb;

  reg [15:0] A, B, C, D, E;
  reg CLK;
  wire [15:0] OUT;

  ternary_adder_tree dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .CLK(CLK),
    .OUT(OUT)
  );

  initial begin
    CLK = 0;
    #10;
    A = 8'b0000000000000000;
    B = 8'b0000000000000001;
    C = 8'b0000000000000010;
    D = 8'b0000000000000011;
    E = 8'b0000000000000100;
    #10;
    $display("A=%h B=%h C=%h D=%h E=%h", A, B, C, D, E);
    #10;
    $display("OUT=%h", OUT);
    #10;
    A = 8'b1111111111111111;
    B = 8'b0000000000000000;
    C = 8'b0000000000000000;
    D = 8'b0000000000000000;
    E = 8'b0000000000000000;
    #10;
    $display("A=%h B=%h C=%h D=%h E=%h", A, B, C, D, E);
    #10;
    $display("OUT=%h", OUT);
    #10;
    A = 8'b0000000000000000;
    B = 8'b0000000000000000;
    C = 8'b0000000000000000;
    D = 8'b0000000000000000;
    E = 8'b0000000000000000;
    #10;
    $display("A=%h B=%h C=%h D=%h E=%h", A, B, C, D, E);
    #10;
    $display("OUT=%h", OUT);
    #10;
    $finish;
  end

  always #5 CLK = ~CLK;

endmodule