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

  property p_write_access;
    @(posedge clk)
    $past(we) && !we -> ram[write_addr] == $past(ram[write_addr]);
  endproperty

  property p_read_access;
    @(posedge clk)
    !we && read_addr >= 0 && read_addr <= 63 -> q == ram[read_addr];
  endproperty

  property p_address_range;
    read_addr >= 0 && read_addr <= 63;
  endproperty

  property p_write_address_range;
    write_addr >= 0 && write_addr <= 63;
  endproperty

  assert property (p_write_access);
  assert property (p_read_access);
  assert property (p_address_range);
  assert property (p_write_address_range);


endmodule