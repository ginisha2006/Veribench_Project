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
    forever #5 CLK = ~CLK;
  end

  initial begin
    A = 8'b0000000000000000;
    B = 8'b0000000000000001;
    C = 8'b0000000000000010;
    D = 8'b0000000000000100;
    E = 8'b0000000000001000;
    #100;
    $finish;
  end

  always @(posedge CLK) begin
    $monitor("A=%h B=%h C=%h D=%h E=%h CLK=%b OUT=%h", A, B, C, D, E, CLK, OUT);
  end

endmodule