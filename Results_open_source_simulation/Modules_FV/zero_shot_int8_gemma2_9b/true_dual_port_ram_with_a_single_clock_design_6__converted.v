module tb_true_dpram_sclk;

  reg clk;
  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b;
  wire [7:0] q_a, q_b;

  true_dpram_sclk dut (
    .data_a(data_a),
    .data_b(data_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .clk(clk),
    .q_a(q_a),
    .q_b(q_b)
  );

  assert (@(posedge clk)
      $past(we_a) && addr_a == addr_a ? q_a == data_a : q_a == $past(ram[addr_a]));
  assert (@(posedge clk)
      $past(we_b) && addr_b == addr_b ? q_b == data_b : q_b == $past(ram[addr_b]));

  always #5 clk = ~clk;

  initial begin
    addr_a = 0;
    addr_b = 0;
    data_a = 8'hAA;
    data_b = 8'hBB;
    we_a = 1;
    we_b = 1;
    #10;
    we_a = 0;
    we_b = 0;
    #10;
    addr_a = 1;
    addr_b = 1;
    data_a = 8'hCC;
    data_b = 8'hDD;
    we_a = 1;
    we_b = 1;
    #10;
    we_a = 0;
    we_b = 0;
    #10;
  end

endmodule