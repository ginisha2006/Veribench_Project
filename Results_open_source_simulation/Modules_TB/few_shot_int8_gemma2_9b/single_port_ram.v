module tb_single_port_ram;
  // Inputs
  reg [7:0] data;
  reg [5:0] addr;
  reg we;
  reg clk;
  // Output
  wire [7:0] q;
  // Instantiate the Single Port RAM
  single_port_ram uut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
  );
  initial begin
    clk = 0; forever #5 clk = ~clk; end
    initial begin
      // Initialize data
      data = 8'hAA;
      // Write sequence
      addr = 6'h00; we = 1; #10;
      addr = 6'h01; we = 1; #10;
      addr = 6'h02; we = 1; #10;
      // Read sequence
      addr = 6'h00; we = 0; #10;
      addr = 6'h01; we = 0; #10;
      addr = 6'h02; we = 0; #10;
      $finish;
    end
    // Monitor signals
    $monitor("Time	addr	we	data	q", $time, addr, we, data, q);
  endmodule