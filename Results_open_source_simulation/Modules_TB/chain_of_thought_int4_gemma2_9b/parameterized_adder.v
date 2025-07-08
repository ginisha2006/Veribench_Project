module param_adder_tb;

  reg [7:0] a;
  reg [7:0] b;
  wire [7:0] sum;
  wire carry;

  param_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  initial begin
    $dumpfile("param_adder_sim.vcd");
    $dumpvars(0, param_adder_tb);

    a = 8'b00000001;
    b = 8'b00000010;
    #10;

    a = 8'b11111111;
    b = 8'b00000001;
    #10;

    a = 8'b00000000;
    b = 8'b00000000;
    #10;

    a = 8'b10101010;
    b = 8'b01010101;
    #10;

    $finish;
  end

  always @(posedge clk) begin
    $monitor("Time: %t, a: %h, b: %h, sum: %h, carry: %b", $time, a, b, sum, carry);
  end

endmodule