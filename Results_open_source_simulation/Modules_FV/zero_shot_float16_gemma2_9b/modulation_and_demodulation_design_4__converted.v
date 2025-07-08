module tb_mod_demod;

  parameter DATA_WIDTH = 16;

  reg clk;
  reg rst;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] modulated_signal;
  wire [DATA_WIDTH-1:0] demodulated_data;

  mod_demod dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .modulated_signal(modulated_signal),
    .demodulated_data(demodulated_data)
  );

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(data_in) != data_in |-> modulated_signal == data_in ^ {DATA_WIDTH{1'b1}});
  assert (@(posedge clk)
      $past(modulated_signal) != modulated_signal |-> demodulated_data == modulated_signal ^ {DATA_WIDTH{1'b1}});

endmodule