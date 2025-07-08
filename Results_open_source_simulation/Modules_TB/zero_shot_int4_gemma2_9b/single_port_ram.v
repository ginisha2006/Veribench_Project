module single_port_ram_tb;

  reg [7:0] data;
  reg [5:0] addr;
  reg we;
  reg clk;
  wire [7:0] q;

  single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Test case 1: Write and read
    addr = 0;
    data = 8'hAA;
    we = 1;
    #10;
    we = 0;
    $display("Address: %d, Data: %h", addr, q);

    // Test case 2: Write multiple values
    addr = 1;
    data = 8'hBB;
    we = 1;
    #10;
    addr = 2;
    data = 8'hCC;
    we = 1;
    #10;
    we = 0;
    $display("Address: %d, Data: %h", addr, q);

    // Test case 3: Read uninitialized value
    addr = 3;
    we = 0;
    $display("Address: %d, Data: %h", addr, q);
  end

endmodule