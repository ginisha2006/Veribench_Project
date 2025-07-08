module tb_behav_counter();

  // Inputs
  reg clk;
  reg [7:0] d;
  reg clear;
  reg load;
  reg up_down;

  // Output
  wire [7:0] cnt;

  // Instantiate the DUT
  behav_counter UUT (
   .d(d),
   .clk(clk),
   .clear(clear),
   .load(load),
   .up_down(up_down),
   .qd(cnt)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if counter resets to zero when clear is high
  property p_clear_to_zero;
    @(posedge clk) disable iff (!clear) ($rose(clear) |=> cnt == 8'h00);
  endproperty
  assert property (p_clear_to_zero);

  // Property: Check if counter loads with new value when load is high
  property p_load_new_value;
    @(posedge clk) disable iff (!load) ($rose(load) |=> cnt == d);
  endproperty
  assert property (p_load_new_value);

  // Property: Check if counter increments when up_down is high
  property p_up_down_increment;
    @(posedge clk) disable iff (!up_down) ((cnt < 8'hFF) |=> cnt == cnt + 1);
  endproperty
  assert property (p_up_down_increment);

  // Property: Check if counter decrements when up_down is low
  property p_up_down_decrement;
    @(posedge clk) disable iff (up_down) ((cnt > 8'h00) |=> cnt == cnt - 1);
  endproperty
  assert property (p_up_down_decrement);

endmodule