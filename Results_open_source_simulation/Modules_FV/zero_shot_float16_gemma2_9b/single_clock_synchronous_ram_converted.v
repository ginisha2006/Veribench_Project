module tb_ram_infer;

  reg [7:0] data;
  reg [5:0] read_addr;
  reg [5:0] write_addr;
  reg we;
  reg clk;
  wire [7:0] q;

  ram_infer dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  assert (@(posedge clk)
      $past(we) == 1 && data != 8'bzzzzzzzz ? ram[write_addr] == data : 1);
  assert (@(posedge clk)
      ram[read_addr] == q);

  always #5 clk = ~clk;

endmodule