module tb_mod_demod #(parameter DATA_WIDTH = 16);

  // Inputs
  reg clk, rst;
  reg [DATA_WIDTH-1:0] data_in;

  // Outputs
  wire [DATA_WIDTH-1:0] modulated_signal, demodulated_data;

  // Instantiate the DUT
  mod_demod #(.DATA_WIDTH(DATA_WIDTH)) UUT (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .modulated_signal(modulated_signal),
   .demodulated_data(demodulated_data)
  );

  // Clock generation for properties
  initial clk = 0;
  always #10 clk = ~clk;

  // Property: Check if modulation is correct
  property p_modulation;
    @(posedge clk) (modulated_signal == (data_in ^ {DATA_WIDTH{1'b1}}));
  endproperty
  assert property (p_modulation);

  // Property: Check if demodulation is correct
  property p_demodulation;
    @(posedge clk) (demodulated_data == (modulated_signal ^ {DATA_WIDTH{1'b1}}));
  endproperty
  assert property (p_demodulation);

endmodule