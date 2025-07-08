module tb_ram_dual;

  logic [7:0] data;
  logic [5:0] read_addr, write_addr;
  logic we, read_clock, write_clock;
  logic [7:0] q;

  ram_dual dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .read_clock(read_clock),
    .write_clock(write_clock),
    .q(q)
  );

  property write_data_correctness;
    @(posedge write_clock)
      $past(we) && data != 0 && write_addr < 64
      -> ram_dual.ram[write_addr] == data;
  endproperty

  property read_data_correctness;
    @(posedge read_clock)
      read_addr < 64
      -> ram_dual.q == ram_dual.ram[read_addr];
  endproperty

  assert property(write_data_correctness);
  assert property(read_data_correctness);

  always #1 read_clock = ~read_clock;
  always #2 write_clock = ~write_clock;

endmodule