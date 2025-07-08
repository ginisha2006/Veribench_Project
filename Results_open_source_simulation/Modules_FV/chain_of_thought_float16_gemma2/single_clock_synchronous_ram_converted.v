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

  always #5 clk = ~clk;

  assert (@(posedge clk)
    (we && (write_addr != 64'h0)) -> (ram[write_addr] == data));
  assert (@(posedge clk)
    (~we) -> (q == ram[read_addr]));

endmodule