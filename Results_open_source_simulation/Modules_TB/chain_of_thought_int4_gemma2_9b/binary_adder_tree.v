module binary_adder_tree_tb;

  reg [15:0] A, B, C, D, E;
  reg clk;
  wire [15:0] out;

  binary_adder_tree dut (A, B, C, D, E, clk, out);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    A = 16'b0000_0000_0000_0001;
    B = 16'b0000_0000_0000_0010;
    C = 16'b0000_0000_0000_1000;
    D = 16'b0000_0000_0001_0000;
    E = 16'b0000_0000_0010_0000;
    #10;
    $display("A=%h B=%h C=%h D=%h E=%h", A, B, C, D, E);
    $display("out=%h", out);
    A = 16'b1111_1111_1111_1111;
    B = 16'b0000_0000_0000_0000;
    C = 16'b0000_0000_0000_0000;
    D = 16'b0000_0000_0000_0000;
    E = 16'b0000_0000_0000_0000;
    #10;
    $display("A=%h B=%h C=%h D=%h E=%h", A, B, C, D, E);
    $display("out=%h", out);
    $finish;
  end

endmodule