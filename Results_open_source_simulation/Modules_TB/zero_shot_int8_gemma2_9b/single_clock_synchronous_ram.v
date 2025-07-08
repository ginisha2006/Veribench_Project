module ram_infer_tb;

  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we, clk;
  wire [7:0] q;

  ram_infer dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $monitor("Time: %t, clk: %b, we: %b, read_addr: %h, write_addr: %h, data: %h, q: %h", $time, clk, we, read_addr, write_addr, data, q);
    
    // Test case 1: Write and Read
    data = 8'hAA;
    write_addr = 6'h00;
    we = 1;
    #10;
    read_addr = 6'h00;
    we = 0;
    #10;

    // Test case 2: Write multiple values
    data = 8'hBB;
    write_addr = 6'h01;
    we = 1;
    #10;
    data = 8'hCC;
    write_addr = 6'h02;
    we = 1;
    #10;
    read_addr = 6'h01;
    we = 0;
    #10;
    read_addr = 6'h02;
    we = 0;
    #10;

    // Test case 3: Read uninitialized value
    read_addr = 6'h03;
    we = 0;
    #10;

    // Test case 4: Write beyond capacity
    write_addr = 6'h40;
    we = 1;
    #10;

  end

endmodule