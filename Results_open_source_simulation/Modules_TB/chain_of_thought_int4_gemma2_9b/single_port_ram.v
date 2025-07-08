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
    data = 8'b00000000;
    addr = 6'b000000;
    we = 1;
    #10;
    data = 8'b11111111;
    addr = 6'b000001;
    we = 1;
    #10;
    we = 0;
    #10;
    $display("Data at address 0: %h", q);
    $display("Data at address 1: %h", dut.ram[1]);
    #10;
  end

endmodule