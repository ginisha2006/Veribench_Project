module tb_ram_dual;

  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we;
  reg read_clock, write_clock;
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

  always #5 read_clock = ~read_clock;
  always #10 write_clock = ~write_clock;

  always @(*) begin assert (@(posedge read_clock) q == ram[read_addr]); end
  always @(*) begin assert (@(posedge write_clock) ram[write_addr] == data); end

endmodule