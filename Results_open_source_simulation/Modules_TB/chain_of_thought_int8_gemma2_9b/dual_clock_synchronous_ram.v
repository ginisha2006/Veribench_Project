module ram_dual_tb;

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

  initial begin
    $dumpfile("ram_dual_tb.vcd");
    $dumpvars(0, ram_dual_tb);
  end

  always #5 read_clock = ~read_clock;
  always #10 write_clock = ~write_clock;

  initial begin
    data = 8'h00;
    write_addr = 6'h00;
    we = 1'b1;
    #15;
    data = 8'hFF;
    write_addr = 6'h10;
    we = 1'b1;
    #15;
    read_addr = 6'h00;
    #15;
    read_addr = 6'h10;
    #15;
    $finish;
  end

endmodule