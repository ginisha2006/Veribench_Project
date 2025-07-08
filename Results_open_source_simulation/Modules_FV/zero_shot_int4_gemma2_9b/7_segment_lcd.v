module tb_seven_seg_display;

  reg [3:0] data;
  wire [6:0] seg;

  seven_seg_display dut (
    .data(data),
    .seg(seg)
  );

  property p_valid_output;
    @(posedge clk) data == 4'h0 || data == 4'h1 || data == 4'h2 || data == 4'h3 || data == 4'h4 || data == 4'h5 || data == 4'h6 || data == 4'h7 || data == 4'h8 || data == 4'h9 || data == 4'hA || data == 4'hB || data == 4'hC || data == 4'hD || data == 4'hE || data == 4'hF;
  endproperty

  assert property (p_valid_output);

  always #5 clk = ~clk;
  reg clk;

endmodule