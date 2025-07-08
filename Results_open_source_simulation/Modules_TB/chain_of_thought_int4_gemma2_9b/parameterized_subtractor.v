module param_subtractor_tb;

  reg [7:0] a;
  reg [7:0] b;
  wire [7:0] diff;
  wire borrow;

  param_subtractor #( .WIDTH(8) ) dut (a, b, diff, borrow);

  initial begin
    $dumpfile("param_subtractor.vcd");
    $dumpvars(0, param_subtractor_tb);

    a = 8'hFF;
    b = 8'hAA;
    #10;

    a = 8'h00;
    b = 8'hFF;
    #10;

    a = 8'h55;
    b = 8'h66;
    #10;

    $finish;
  end

  always @(posedge clk) begin
    $monitor("Time: %t, a: %h, b: %h, diff: %h, borrow: %b", $time, a, b, diff, borrow);
  end

endmodule