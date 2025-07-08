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
    $dumpfile("ram_dual.vcd");
    $dumpvars(0, ram_dual_tb);
    
    // Test Case 1: Write and Read
    data = 8'hAA;
    write_addr = 6'h00;
    we = 1'b1;
    #10;
    read_addr = 6'h00;
    read_clock = 1'b1;
    #10;
    read_clock = 1'b0;
    #10;

    // Test Case 2: Write Multiple Values
    data = 8'hBB;
    write_addr = 6'h01;
    we = 1'b1;
    #10;
    data = 8'hCC;
    write_addr = 6'h02;
    we = 1'b1;
    #10;
    read_addr = 6'h01;
    read_clock = 1'b1;
    #10;
    read_clock = 1'b0;
    #10;
    read_addr = 6'h02;
    read_clock = 1'b1;
    #10;
    read_clock = 1'b0;
    #10;

    // Test Case 3: Out of Bounds Access
    data = 8'hDD;
    write_addr = 6'h40;
    we = 1'b1;
    #10;
    read_addr = 6'h40;
    read_clock = 1'b1;
    #10;
    read_clock = 1'b0;
    #10;

    $finish;
  end

  always #5 read_clock = ~read_clock;
  always #10 write_clock = ~write_clock;

endmodule