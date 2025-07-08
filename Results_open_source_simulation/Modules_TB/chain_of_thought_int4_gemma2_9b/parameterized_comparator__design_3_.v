module param_comparator_tb;
  reg [7:0] A;
  reg [7:0] B;
  wire Equal;
  wire Greater;
  wire Less;
  param_comparator #( .WIDTH(8) ) dut (A, B, Equal, Greater, Less);
  initial begin
    A = 8'b00000000;
    B = 8'b00000000;
    #10;
    A = 8'b00000001;
    B = 8'b00000000;
    #10;
    A = 8'b11111111;
    B = 8'b00000000;
    #10;
    A = 8'b00000000;
    B = 8'b11111111;
    #10;
    A = 8'b00000001;
    B = 8'b00000001;
    #10;
    A = 8'b10101010;
    B = 8'b10101010;
    #10;
    A = 8'b10101011;
    B = 8'b10101010;
    #10;
    A = 8'b10101010;
    B = 8'b10101011;
    #10;
  end
  always @(posedge clk) begin
    $monitor("A=%b B=%b Equal=%b Greater=%b Less=%b", A, B, Equal, Greater, Less);
  end
endmodule