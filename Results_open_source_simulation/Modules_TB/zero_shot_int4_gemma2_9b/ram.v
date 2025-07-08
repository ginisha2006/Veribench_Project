module ram_simple_tb #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
);

  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;

  ram_simple dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $monitor("Time: %t clk=%b we=%b addr=%h data_in=%h data_out=%h", $time, clk, we, addr, data_in, data_out);
    addr = 0;
    data_in = 8'hAA;
    we = 1;
    #10;
    addr = 1;
    data_in = 8'hBB;
    we = 1;
    #10;
    addr = 0;
    we = 0;
    #10;
    $display("Read back value at address 0: %h", data_out);
    addr = 1;
    we = 0;
    #10;
    $display("Read back value at address 1: %h", data_out);
  end

endmodule