module tb_uart_module ();

  // Inputs
  reg clk;
  reg rst;
  reg rx;
  reg [7:0] data_in;

  // Outputs
  wire tx;
  wire [7:0] data_out;

  // Instantiate the DUT
  uart_module UUT (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .tx(tx),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties

  // Property: Ensure tx is low when idle (no data transmission)
  property p_tx_idle;
    @(posedge clk) disable iff (rst)
      (!data_in && !tx);
  endproperty
  assert property (p_tx_idle);

  // Property: Ensure data_out changes only after valid data_in has been received
  property p_data_sync;
    @(posedge clk) disable iff (rst)
      ##[1:$] (data_in !== 8'bZZZZZZZZ |-> ##1 data_out !== 8'bZZZZZZZZ);
  endproperty
  assert property (p_data_sync);

  // Property: Ensure data_out does not change while receiving new data_in
  property p_no_change_during_rx;
    @(posedge clk) disable iff (rst)
      (data_in !== 8'bZZZZZZZZ |-> ##1 !$stable(data_in) |=> !$changed(data_out));
  endproperty
  assert property (p_no_change_during_rx);

  // Property: Ensure reset clears data_out
  property p_reset_clears_output;
    @(negedge rst) disable iff (rst)
      (data_out === 8'b0);
  endproperty
  assert property (p_reset_clears_output);

  // Property: Ensure tx is high during data transmission
  property p_tx_high_on_transmit;
    @(posedge clk) disable iff (rst)
      (data_in !== 8'bZZZZZZZZ |-> ##1 tx);
  endproperty
  assert property (p_tx_high_on_transmit);

endmodule