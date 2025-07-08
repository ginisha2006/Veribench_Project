module binary_adder_tree_tb();

  reg [15:0] A, B, C, D, E;
  reg clk;
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
    // Stimulus
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

  always @(posedge clk) begin
    $display("A=%h B=%h C=%h D=%h E=%h", A, B, C, D, E);
    $display("out=%h", out);
  end

endmodule