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
    $past(we) && !we -> ram[write_addr] == $past(ram[write_addr]));
  assert (@(posedge clk)
    !we && read_addr >= 0 && read_addr <= 63 -> q == ram[read_addr]);
  always @(*) begin assert (read_addr >= 0 && read_addr <= 63); end
  always @(*) begin assert (write_addr >= 0 && write_addr <= 63); end


endmodule