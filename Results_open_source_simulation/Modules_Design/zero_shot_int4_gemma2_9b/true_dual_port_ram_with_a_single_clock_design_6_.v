module true_dpram_sclk (
  data_a,
  data_b,
  addr_a,
  addr_b,
  we_a,
  we_b,
  clk,
  q_a,
  q_b
);

  input [7:0] data_a;
  input [7:0] data_b;
  input [5:0] addr_a;
  input [5:0] addr_b;
  input we_a;
  input we_b;
  input clk;
  output [7:0] q_a;
  output [7:0] q_b;

  reg [7:0] ram [0:31];

  always @(posedge clk) begin
    if (we_a) ram[addr_a] <= data_a;
    if (we_b) ram[addr_b] <= data_b;
  end

  assign q_a = ram[addr_a];
  assign q_b = ram[addr_b];

endmodule