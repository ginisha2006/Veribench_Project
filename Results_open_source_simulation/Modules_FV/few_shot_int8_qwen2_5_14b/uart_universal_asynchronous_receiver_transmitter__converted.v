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
  assert (@(posedge clk) disable iff (rst)
      (!data_in && !tx));

  // Property: Ensure data_out changes only after valid data_in has been received
  assert (@(posedge clk) disable iff (rst)
      ##[1:$] (data_in !== 8'bZZZZZZZZ |-> ##1 data_out !== 8'bZZZZZZZZ));

  // Property: Ensure data_out does not change while receiving new data_in
  assert (@(posedge clk) disable iff (rst)
      (data_in !== 8'bZZZZZZZZ |-> ##1 !$stable(data_in) |=> !$changed(data_out)));

  // Property: Ensure reset clears data_out
  assert (@(negedge rst) disable iff (rst)
      (data_out === 8'b0));

  // Property: Ensure tx is high during data transmission
  assert (@(posedge clk) disable iff (rst)
      (data_in !== 8'bZZZZZZZZ |-> ##1 tx));

endmodule