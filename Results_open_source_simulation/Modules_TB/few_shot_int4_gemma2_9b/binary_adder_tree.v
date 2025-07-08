module tb_binary_adder_tree;
  reg clk;
  reg [15:0] A, B, C, D, E;
  wire [15:0] out;

  binary_adder_tree dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .clk(clk),
    .out(out)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Stimulus for testing
    A = 16'hAAAA;
    B = 16'hBBBB;
    C = 16'hCCCC;
    D = 16'hDDDD;
    E = 16'hEEEE;
    #100;
    A = 16'hFFFF;
    B = 16'h0000;
    C = 16'h0000;
    D = 16'h0000;
    E = 16'h0000;
    #100;
    $finish;
  end

  // Monitor signals
  initial begin
    $monitor("Time %0d clk %b A %h B %h C %h D %h E %h out %h", $time, clk, A, B, C, D, E, out);
  end

endmodule