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
    // Clock generation
    forever #5 read_clock = ~read_clock;
    forever #10 write_clock = ~write_clock;
    // Test sequence
    data = 8'hAA; write_addr = 6'h00; we = 1; #10;
    data = 8'hBB; write_addr = 6'h01; we = 1; #10;
    we = 0; read_addr = 6'h00; #10;
    $display("Read Data: %h", q);
    read_addr = 6'h01; #10;
    $display("Read Data: %h", q);
    $finish;
  end
endmodule