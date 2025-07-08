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

  initial begin
    $dumpfile("ram_dual.vcd");
    $dumpvars(0, tb_ram_dual);
    // Initialize data and addresses
    data = 8'hAA;
    write_addr = 6'h00;
    read_addr = 6'h00;
    we = 1'b1;
    // Apply clock cycles
    #10 write_clock = 1'b1;
    #10 write_clock = 1'b0;
    #10 read_clock = 1'b1;
    #10 read_clock = 1'b0;
    // Verify read operation
    $display("Data written: %h", data);
    $display("Read data: %h", q);
    // Change address and repeat
    write_addr = 6'h10;
    read_addr = 6'h10;
    #10 write_clock = 1'b1;
    #10 write_clock = 1'b0;
    #10 read_clock = 1'b1;
    #10 read_clock = 1'b0;
    $display("Data written: %h", data);
    $display("Read data: %h", q);
    $finish;
  end
endmodule