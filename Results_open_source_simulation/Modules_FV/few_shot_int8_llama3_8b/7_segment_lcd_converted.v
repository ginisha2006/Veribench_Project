module tb_seven_seg_display #(parameter DATA_WIDTH = 4)();

  // Inputs
  reg clk;
  reg [DATA_WIDTH-1:0] data;

  // Outputs
  wire [6:0] seg;

  // Instantiate the DUT
  seven_seg_display #(.DATA_WIDTH(DATA_WIDTH)) UUT (
   .data(data),
   .seg(seg)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if the segment values match the expected values
  assert (@(posedge clk) ((data == 4'h0) => (seg == 7'b1000000))
    | (data == 4'h1) => (seg == 7'b1111001)
    | (data == 4'h2) => (seg == 7'b0100100)
    | (data == 4'h3) => (seg == 7'b0110000)
    | (data == 4'h4) => (seg == 7'b0011001)
    | (data == 4'h5) => (seg == 7'b0010010)
    | (data == 4'h6) => (seg == 7'b0000010)
    | (data == 4'h7) => (seg == 7'b1111000)
    | (data == 4'h8) => (seg == 7'b0000000)
    | (data == 4'h9) => (seg == 7'b0011000)
    | (data == 4'hA) => (seg == 7'b0001000)
    | (data == 4'hB) => (seg == 7'b0000011)
    | (data == 4'hC) => (seg == 7'b1000110)
    | (data == 4'hD) => (seg == 7'b0100001)
    | (data == 4'hE) => (seg == 7'b0000110)
    | (data == 4'hF) => (seg == 7'b0001110)
    | (default) => (seg == 7'b1111111));

endmodule