module tb_seven_seg_display;

  reg [3:0] data;
  wire [6:0] seg;

  seven_seg_display dut (
    .data(data),
    .seg(seg)
  );

  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) seg == {data[0], data[1], data[2], data[3]}); end
  always @(*) begin assert ($rose(clk) -> (seg == 7'b1000000 || seg == 7'b1111001 || seg == 7'b0100100 || seg == 7'b0110000 || seg == 7'b0011001 || seg == 7'b0010010 || seg == 7'b0000010 || seg == 7'b1111000 || seg == 7'b0000000 || seg == 7'b0011000 || seg == 7'b0001000 || seg == 7'b0000011 || seg == 7'b1000110 || seg == 7'b0100001 || seg == 7'b0000110 || seg == 7'b0001110)); end

endmodule