module tb_single_port_ram;

  reg [7:0] data;
  reg [5:0] addr;
  reg we;
  reg clk;
  wire [7:0] q;

  single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  assert (@(posedge clk)
    $past(we) && we == 1'b1
      ? ram[addr] == data
      : ram[addr] == $past(ram[addr]));
  assert (@(posedge clk)
    $past(we) && we == 1'b0
      ? ram[addr] == q
      : ram[addr] == $past(ram[addr]));
  always @(*) begin assert (0 <= addr && addr <= 63); end

  always #5 clk = ~clk;

endmodule