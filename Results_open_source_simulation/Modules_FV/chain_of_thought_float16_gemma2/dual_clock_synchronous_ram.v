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

  property write_data_correct;
    @(posedge write_clock)
      (we && (write_addr >= 0 && write_addr <= 63))
        -> (ram[write_addr] == data);
  endproperty

  property read_data_correct;
    @(posedge read_clock)
      (read_addr >= 0 && read_addr <= 63)
        -> (q == ram[read_addr]);
  endproperty

  assert property(write_data_correct);
  assert property(read_data_correct);

  always #5 read_clock = ~read_clock;
  always #10 write_clock = ~write_clock;

endmodule