module tb_ternary_adder_tree;
  parameter WIDTH = 16;
  reg clk;
  reg [WIDTH-1:0] A, B, C, D, E;
  wire [WIDTH-1:0] OUT;

  // Instantiate the Ternary Adder Tree
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
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Stimulus for testing
    A = 0; B = 1; C = 2; D = 3; E = 4; #10;
    A = 5; B = 6; C = 7; D = 8; E = 9; #10;
    A = 10; B = 11; C = 12; D = 13; E = 14; #10;
    A = 15; B = 0; C = 1; D = 2; E = 3; #10;
    A = {WIDTH{1'b1}}; B = {WIDTH{1'b0}}; C = {WIDTH{1'b1}}; D = {WIDTH{1'b0}}; E = {WIDTH{1'b1}}; #10;
    $finish;
  end

  // Monitor signals
  always @(posedge clk) begin
    $display("Time %0d: clk=%b A=%b B=%b C=%b D=%b E=%b OUT=%b", $time, clk, A, B, C, D, E, OUT);
  end

endmodule