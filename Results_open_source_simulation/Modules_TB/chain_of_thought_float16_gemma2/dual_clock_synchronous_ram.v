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
    $monitor("Time: %t, data: %h, read_addr: %h, write_addr: %h, we: %b, q: %h", $time, data, read_addr, write_addr, we, q);
    #10 data = 8'hAA;
    write_addr = 6'h00;
    we = 1'b1;
    #10 we = 1'b0;
    read_addr = 6'h00;
    #10 read_clock = 1'b1;
    #10 read_clock = 1'b0;
    #10 data = 8'hBB;
    write_addr = 6'h01;
    we = 1'b1;
    #10 we = 1'b0;
    read_addr = 6'h01;
    #10 read_clock = 1'b1;
    #10 read_clock = 1'b0;
    $finish;
  end

  always #5 read_clock = ~read_clock;
  always #10 write_clock = ~write_clock;

endmodule