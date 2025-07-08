module tb_ram_dual;

  reg [7:0] data;
  reg [5:0] read_addr;
  reg [5:0] write_addr;
  reg we;
  reg read_clock;
  reg write_clock;
  wire [7:0] q;

  ram_dual dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .read_clock(read_clock),
    .write_clock(write_clock),
    .q(q)
  );

  property p_write_access;
    @(posedge write_clock) write_addr within {0, 63} && we == 1 -> ram[write_addr] == data;
  endproperty

  property p_read_access;
    @(posedge read_clock) read_addr within {0, 63} -> q == ram[read_addr];
  endproperty

  assert property (p_write_access);
  assert property (p_read_access);

  always #5 read_clock = ~read_clock;
  always #10 write_clock = ~write_clock;

endmodule