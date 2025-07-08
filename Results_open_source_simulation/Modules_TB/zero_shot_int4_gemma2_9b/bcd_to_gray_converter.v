module bcd_to_gray_tb;
  reg [3:0] bcd;
  wire [3:0] gray;
  bcd_to_gray dut (
    .bcd(bcd),
    .gray(gray)
  );
  initial begin
    $dumpfile("bcd_to_gray.vcd");
    $dumpvars(0, bcd_to_gray_tb);
    bcd = 0;
    #10;
    bcd = 1;
    #10;
    bcd = 2;
    #10;
    bcd = 3;
    #10;
    bcd = 9;
    #10;
    bcd = 10;
    #10;
    bcd = 15;
    #10;
    $finish;
  end
  always @(posedge clk) begin
    $monitor("bcd=%b gray=%b", bcd, gray);
  end
  
endmodule