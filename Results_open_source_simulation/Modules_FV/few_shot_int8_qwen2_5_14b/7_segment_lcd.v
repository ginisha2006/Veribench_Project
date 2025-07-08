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
  property p_data_0;
    (data === 4'h0) |-> (seg === 7'b1000000);
  endproperty
  assert property (p_data_0);

  property p_data_1;
    (data === 4'h1) |-> (seg === 7'b1111001);
  endproperty
  assert property (p_data_1);

  property p_data_2;
    (data === 4'h2) |-> (seg === 7'b0100100);
  endproperty
  assert property (p_data_2);

  property p_data_3;
    (data === 4'h3) |-> (seg === 7'b0110000);
  endproperty
  assert property (p_data_3);

  property p_data_4;
    (data === 4'h4) |-> (seg === 7'b0011001);
  endproperty
  assert property (p_data_4);

  property p_data_5;
    (data === 4'h5) |-> (seg === 7'b0010010);
  endproperty
  assert property (p_data_5);

  property p_data_6;
    (data === 4'h6) |-> (seg === 7'b0000010);
  endproperty
  assert property (p_data_6);

  property p_data_7;
    (data === 4'h7) |-> (seg === 7'b1111000);
  endproperty
  assert property (p_data_7);

  property p_data_8;
    (data === 4'h8) |-> (seg === 7'b0000000);
  endproperty
  assert property (p_data_8);

  property p_data_9;
    (data === 4'h9) |-> (seg === 7'b0011000);
  endproperty
  assert property (p_data_9);

  property p_data_A;
    (data === 4'hA) |-> (seg === 7'b0001000);
  endproperty
  assert property (p_data_A);

  property p_data_B;
    (data === 4'hB) |-> (seg === 7'b0000011);
  endproperty
  assert property (p_data_B);

  property p_data_C;
    (data === 4'hC) |-> (seg === 7'b1000110);
  endproperty
  assert property (p_data_C);

  property p_data_D;
    (data === 4'hD) |-> (seg === 7'b0100001);
  endproperty
  assert property (p_data_D);

  property p_data_E;
    (data === 4'hE) |-> (seg === 7'b0000110);
  endproperty
  assert property (p_data_E);

  property p_data_F;
    (data === 4'hF) |-> (seg === 7'b0001110);
  endproperty
  assert property (p_data_F);

  property p_default_case;
    (!$onehot(data)) |-> (seg === 7'b1111111);
  endproperty
  assert property (p_default_case);

endmodule