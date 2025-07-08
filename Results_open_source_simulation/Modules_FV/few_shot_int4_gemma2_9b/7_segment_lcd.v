module tb_seven_seg_display #(parameter DATA_WIDTH = 4)();

  // Inputs
  reg [DATA_WIDTH-1:0] data;
  reg clk;

  // Outputs
  wire [6:0] seg;

  // Instantiate the DUT
  seven_seg_display #( .DATA_WIDTH(DATA_WIDTH) ) UUT (
    .data(data),
    .seg(seg)
  );

  // Clock generation for property evaluation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_valid_segment;
    @(posedge clk) $bitrange(seg[0], seg[6]) == {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
  endproperty
  assert property (p_valid_segment);

  property p_correct_segments;
    @(posedge clk) case (data)
      4'h0: $bitrange(seg[0], seg[6]) == 7'b1000000;
      4'h1: $bitrange(seg[0], seg[6]) == 7'b1111001;
      4'h2: $bitrange(seg[0], seg[6]) == 7'b0100100;
      4'h3: $bitrange(seg[0], seg[6]) == 7'b0110000;
      4'h4: $bitrange(seg[0], seg[6]) == 7'b0011001;
      4'h5: $bitrange(seg[0], seg[6]) == 7'b0010010;
      4'h6: $bitrange(seg[0], seg[6]) == 7'b0000010;
      4'h7: $bitrange(seg[0], seg[6]) == 7'b1111000;
      4'h8: $bitrange(seg[0], seg[6]) == 7'b0000000;
      4'h9: $bitrange(seg[0], seg[6]) == 7'b0011000;
      4'hA: $bitrange(seg[0], seg[6]) == 7'b0001000;
      4'hB: $bitrange(seg[0], seg[6]) == 7'b0000011;
      4'hC: $bitrange(seg[0], seg[6]) == 7'b1000110;
      4'hD: $bitrange(seg[0], seg[6]) == 7'b0100001;
      4'hE: $bitrange(seg[0], seg[6]) == 7'b0000110;
      4'hF: $bitrange(seg[0], seg[6]) == 7'b0001110;
      default: $bitrange(seg[0], seg[6]) == 7'b1111111;
    endcase;
  endproperty
  assert property (p_correct_segments);


endmodule