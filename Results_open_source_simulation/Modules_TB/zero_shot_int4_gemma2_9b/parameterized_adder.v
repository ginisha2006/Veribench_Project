module param_adder_tb;

  reg [7:0] a;
  reg [7:0] b;
  wire [7:0] sum;
  wire carry;

  param_adder #( .WIDTH(8) ) dut (a, b, sum, carry);

  initial begin
    $dumpfile("param_adder_tb.vcd");
    $dumpvars(0, param_adder_tb);

    // Test Case 1: Positive Numbers
    a = 8'b00000001;
    b = 8'b00000010;
    #10;
    $display("Test Case 1: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);

    // Test Case 2: Negative Numbers
    a = 8'b11111111;
    b = 8'b11111111;
    #10;
    $display("Test Case 2: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);

    // Test Case 3: Overflow
    a = 8'b11111111;
    b = 8'b00000001;
    #10;
    $display("Test Case 3: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);

    // Test Case 4: Zero Addition
    a = 8'b00000000;
    b = 8'b00000000;
    #10;
    $display("Test Case 4: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);

    $finish;
  end

endmodule