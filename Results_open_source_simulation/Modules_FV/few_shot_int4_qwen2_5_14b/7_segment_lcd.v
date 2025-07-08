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
  property p_data_0_to_F;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data inside {[4'h0 : 4'hF]});
  endproperty
  assert property (p_data_0_to_F);

  property p_segment_output;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h0 |-> seg === 7'b1000000);
  endproperty
  assert property (p_segment_output);

  property p_segment_output_1;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h1 |-> seg === 7'b1111001);
  endproperty
  assert property (p_segment_output_1);

  property p_segment_output_2;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h2 |-> seg === 7'b0100100);
  endproperty
  assert property (p_segment_output_2);

  property p_segment_output_3;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h3 |-> seg === 7'b0110000);
  endproperty
  assert property (p_segment_output_3);

  property p_segment_output_4;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h4 |-> seg === 7'b0011001);
  endproperty
  assert property (p_segment_output_4);

  property p_segment_output_5;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h5 |-> seg === 7'b0010010);
  endproperty
  assert property (p_segment_output_5);

  property p_segment_output_6;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h6 |-> seg === 7'b0000010);
  endproperty
  assert property (p_segment_output_6);

  property p_segment_output_7;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h7 |-> seg === 7'b1111000);
  endproperty
  assert property (p_segment_output_7);

  property p_segment_output_8;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h8 |-> seg === 7'b0000000);
  endproperty
  assert property (p_segment_output_8);

  property p_segment_output_9;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'h9 |-> seg === 7'b0011000);
  endproperty
  assert property (p_segment_output_9);

  property p_segment_output_A;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hA |-> seg === 7'b0001000);
  endproperty
  assert property (p_segment_output_A);

  property p_segment_output_B;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hB |-> seg === 7'b0000011);
  endproperty
  assert property (p_segment_output_B);

  property p_segment_output_C;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hC |-> seg === 7'b1000110);
  endproperty
  assert property (p_segment_output_C);

  property p_segment_output_D;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hD |-> seg === 7'b0100001);
  endproperty
  assert property (p_segment_output_D);

  property p_segment_output_E;
    @(posedge $rose(data))
    disable iff (!$changed(data))
    (data == 4'hE |-> seg === 7'b0000110);
  endproperty
  assert property (p_segment_output_E);