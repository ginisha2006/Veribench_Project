module tb_mod_demod;

  reg clk;
  reg rst;
  reg [15:0] data_in;
  wire [15:0] modulated_signal;
  wire [15:0] demodulated_data;

  mod_demod #(
    .DATA_WIDTH(16)
  ) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .modulated_signal(modulated_signal),
    .demodulated_data(demodulated_data)
  );

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(data_in) != data_in |-> modulated_signal == data_in ^ {16{1'b1}});
  assert (@(posedge clk)
      $past(modulated_signal) != modulated_signal |-> demodulated_data == modulated_signal ^ {16{1'b1}});

endmodule