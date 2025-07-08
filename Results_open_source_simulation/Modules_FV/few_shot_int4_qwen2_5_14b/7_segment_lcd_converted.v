module tb_seven_seg_display #(
    parameter DATA_WIDTH = 4
)();

  // Inputs
  reg [DATA_WIDTH-1:0] data;

  // Outputs
  wire [6:0] seg;

  // Instantiate the DUT
  seven_seg_display #(.DATA_WIDTH(DATA_WIDTH)) UUT (
    .data(data),
    .seg(seg)
  );

  // Assertions
  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data inside {[4'h0 : 4'hF]}));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h0 |-> seg === 7'b1000000));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h1 |-> seg === 7'b1111001));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h2 |-> seg === 7'b0100100));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h3 |-> seg === 7'b0110000));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h4 |-> seg === 7'b0011001));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h5 |-> seg === 7'b0010010));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h6 |-> seg === 7'b0000010));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h7 |-> seg === 7'b1111000));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h8 |-> seg === 7'b0000000));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h9 |-> seg === 7'b0011000));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hA |-> seg === 7'b0001000));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hB |-> seg === 7'b0000011));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hC |-> seg === 7'b1000110));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hD |-> seg === 7'b0100001));

  assert (@(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hE |-> seg === 7'b0000110));