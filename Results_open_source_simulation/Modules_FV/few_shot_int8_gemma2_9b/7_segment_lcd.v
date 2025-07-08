module tb_seven_seg_display #(parameter DATA_WIDTH = 4);

  reg [DATA_WIDTH-1:0] data;
  wire [6:0] seg;

  seven_seg_display #(DATA_WIDTH) dut (
    .data(data),
    .seg(seg)
  );

  // Assertions
  property p_valid_segment;
    @(posedge clk) $bitvector_range(seg, 0, 6) == 7'b0 || $bitvector_range(seg, 0, 6) == 7'b1;
  endproperty
  assert property (p_valid_segment);

  initial begin
    $dumpfile("seven_seg_display_test.vcd");
    $dumpvars(0, tb_seven_seg_display);
    data = 4'h0;
    #10;
    data = 4'h1;
    #10;
    data = 4'h2;
    #10;
    data = 4'h3;
    #10;
    data = 4'h4;
    #10;
    data = 4'h5;
    #10;
    data = 4'h6;
    #10;
    data = 4'h7;
    #10;
    data = 4'h8;
    #10;
    data = 4'h9;
    #10;
    data = 4'hA;
    #10;
    data = 4'hB;
    #10;
    data = 4'hC;
    #10;
    data = 4'hD;
    #10;
    data = 4'hE;
    #10;
    data = 4'hF;
    #10;
    $finish;
  end

endmodule