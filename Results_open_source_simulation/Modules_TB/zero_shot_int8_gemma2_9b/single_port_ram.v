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
    clk = 0; forever #5 clk = ~clk;
  end

  initial begin
    $monitor("Time: %t, addr=%b, we=%b, data=%b, q=%b", $time, addr, we, data, q);
    
    // Test case 1: Write and read
    addr = 0;
    data = 8'hAA;
    we = 1;
    #10;
    we = 0;
    addr = 0;
    #10;
    
    // Test case 2: Write multiple values
    for (int i = 1; i < 64; i++) begin
      addr = i;
      data = i * 8'hFF;
      we = 1;
      #10;
    end
    we = 0;
    
    // Test case 3: Read all values
    for (int i = 0; i < 64; i++) begin
      addr = i;
      #10;
    end
  end

endmodule