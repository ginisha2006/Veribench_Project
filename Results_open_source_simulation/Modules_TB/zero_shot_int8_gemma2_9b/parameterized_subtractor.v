module param_subtractor_tb;

  reg [7:0] a;
  reg [7:0] b;
  wire [7:0] diff;
  wire borrow;

  param_subtractor dut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
  );

  initial begin
    $dumpfile("param_subtractor_tb.vcd");
    $dumpvars(0, param_subtractor_tb);

    // Test Case 1
    a = 8'hFF;
    b = 8'h00;
    #10;

    // Test Case 2
    a = 8'h00;
    b = 8'hFF;
    #10;

    // Test Case 3
    a = 8'hAA;
    b = 8'h55;
    #10;

    // Test Case 4
    a = 8'h01;
    b = 8'h01;
    #10;

    $finish;
  end

  always @(posedge clk) begin
    $monitor("Time: %t ns, a: %h, b: %h, diff: %h, borrow: %b", $time, a, b, diff, borrow);
  end

endmodule