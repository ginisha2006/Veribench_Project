module binary_adder_tree_tb();

  reg [15:0] A, B, C, D, E;
  reg clk;
  wire [15:0] out;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    A = 16'hAAAA;
    B = 16'hBBBB;
    C = 16'hCCCC;
    D = 16'hDDDD;
    E = 16'hEEEE;
    #10;
    $monitor("A=%h B=%h C=%h D=%h E=%h clk=%b out=%h", A, B, C, D, E, clk, out);
    A = 16'hFFFF;
    B = 16'h0000;
    C = 16'h0000;
    D = 16'hFFFF;
    E = 16'h0000;
    #10;
    $monitor("A=%h B=%h C=%h D=%h E=%h clk=%b out=%h", A, B, C, D, E, clk, out);
    A = 16'h0000;
    B = 16'h0000;
    C = 16'h0000;
    D = 16'h0000;
    E = 16'h0000;
    #10;
    $monitor("A=%h B=%h C=%h D=%h E=%h clk=%b out=%h", A, B, C, D, E, clk, out);
  end

endmodule