module bcd_to_gray_tb;

  reg [3:0] bcd;
  wire [3:0] gray;

  bcd_to_gray dut (
    .bcd(bcd),
    .gray(gray)
  );

  initial begin
    $monitor("bcd: %b, gray: %b", bcd, gray);
    bcd = 4'b0000; #10;
    bcd = 4'b0001; #10;
    bcd = 4'b0010; #10;
    bcd = 4'b0011; #10;
    bcd = 4'b0100; #10;
    bcd = 4'b0101; #10;
    bcd = 4'b0110; #10;
    bcd = 4'b0111; #10;
    bcd = 4'b1000; #10;
    bcd = 4'b1001; #10;
    bcd = 4'b1010; #10;
    bcd = 4'b1011; #10;
    bcd = 4'b1100; #10;
    bcd = 4'b1101; #10;
    bcd = 4'b1110; #10;
    bcd = 4'b1111; #10;
  end

endmodule