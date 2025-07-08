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
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
    // Test sequence
    data = 8'hAA; addr = 6'h00; we = 1; #10;
    data = 8'hBB; addr = 6'h01; we = 1; #10;
    data = 8'hCC; addr = 6'h02; we = 1; #10;
    we = 0; addr = 6'h00; #10;
    $display("Data at address 0x%x: %h", addr, q);
    addr = 6'h01; #10;
    $display("Data at address 0x%x: %h", addr, q);
    addr = 6'h02; #10;
    $display("Data at address 0x%x: %h", addr, q);
    $finish;
  end
endmodule