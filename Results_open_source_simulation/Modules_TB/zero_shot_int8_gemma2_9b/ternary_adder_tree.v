module ternary_adder_tree_tb();

  reg [15:0] A, B, C, D, E;
  reg CLK;
  wire [15:0] OUT;

  ternary_adder_tree dut (A, B, C, D, E, CLK, OUT);

  initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
  end

  initial begin
    A = 16'hAAAA;
    B = 16'hBBBB;
    C = 16'hCCCC;
    D = 16'hDDDD;
    E = 16'hEEEE;
    #10;
    A = 16'hFFFF;
    B = 16'h0000;
    C = 16'h0000;
    D = 16'h0000;
    E = 16'h0000;
    #10;
    A = 16'h0000;
    B = 16'h0000;
    C = 16'h0000;
    D = 16'h0000;
    E = 16'h0000;
    #10;
  end

  $monitor("A=%b B=%b C=%b D=%b E=%b CLK=%b OUT=%b", A, B, C, D, E, CLK, OUT);

endmodule