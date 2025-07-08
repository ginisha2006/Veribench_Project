module tb_behav_counter();

  // Inputs
  reg clk;
  reg clear;
  reg load;
  reg up_down;
  reg [7:0] d;

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

  // Property: Check if counter resets to 0 when clear is high
  property p_clear_reset;
    @(posedge clk) disable iff (!clear) cnt!= 8'h00;
  endproperty
  assert property (p_clear_reset);

  // Property: Check if counter loads with value d when load is high
  property p_load_value;
    @(posedge clk) disable iff (load) cnt == d;
  endproperty
  assert property (p_load_value);

  // Property: Check if counter increments when up_down is high
  property p_up_down_increment;
    @(posedge clk) disable iff (up_down) cnt < 8'hff && cnt + 1 == cnt;
  endproperty
  assert property (p_up_down_increment);

  // Property: Check if counter decrements when up_down is low
  property p_up_down_decrement;
    @(posedge clk) disable iff (!up_down) cnt > 8'h00 && cnt - 1 == cnt;
  endproperty
  assert property (p_up_down_decrement);

endmodule