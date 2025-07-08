module tb_seven_seg_display;

  reg [3:0] data;
  wire [6:0] seg;

  seven_seg_display #(
    .DATA_WIDTH(4)
  ) dut (
    .data(data),
    .seg(seg)
  );

  property p_valid_segment;
    @(posedge clk)
      $display("Data: %h, Seg: %b", data, seg);
    endproperty

  assert property (p_valid_segment);

endmodule