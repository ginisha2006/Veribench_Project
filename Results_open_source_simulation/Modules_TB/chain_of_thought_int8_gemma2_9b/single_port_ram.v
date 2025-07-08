module single_port_ram_tb();

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
    data = 8'b00000001;
    addr = 6'b000000;
    we = 1;
    #10;
    data = 8'b11111111;
    addr = 6'b000001;
    we = 1;
    #10;
    we = 0;
    addr = 6'b000000;
    #10;
    $display("q = %h", q);
    $finish;
  end

endmodule