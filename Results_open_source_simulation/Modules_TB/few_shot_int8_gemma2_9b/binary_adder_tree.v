module tb_binary_adder_tree;
  // Inputs
  reg clk;
  reg [15:0] A, B, C, D, E;
  // Output
  wire [15:0] out;

  // Instantiate the Binary Adder Tree
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
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
    
    // Stimulus
    A = 16'hAAAA;
    B = 16'hBBBB;
    C = 16'hCCCC;
    D = 16'hDDDD;
    E = 16'hEEEE;
    #100; // Wait for some time
    $finish;
  end

  // Monitoring
  initial begin
    $display("Time	A	B	C	D	E	out");
    forever begin
      $display("%0d	%h	%h	%h	%h	%h	%h", $time, A, B, C, D, E, out);
      #10;
    end
  end
endmodule