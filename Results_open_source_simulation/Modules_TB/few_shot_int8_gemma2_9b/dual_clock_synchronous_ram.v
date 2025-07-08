module tb_ram_dual;
  // Inputs
  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we;
  reg read_clock, write_clock;
  // Output
  wire [7:0] q;
  // Instantiate the Dual Clock Synchronous RAM
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
    // Initialize clocks
    read_clock = 0;
    write_clock = 0;
    // Stimulus
    forever begin
      #5 read_clock = ~read_clock;
      #5 write_clock = ~write_clock;
      // Data and address patterns
      data = 8'hAA;
      write_addr = 6'h00;
      we = 1;
      #10
      data = 8'hBB;
      write_addr = 6'h10;
      we = 1;
      #10
      read_addr = 6'h00;
      we = 0;
      #10
      read_addr = 6'h10;
      we = 0;
      #10
    end
  end

  // Monitor signals
  initial begin
    $monitor("Time: %t, Read Addr: %b, Write Addr: %b, We: %b, Q: %b", $time, read_addr, write_addr, we, q);
  end
endmodule