module tb_ram_simple;

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

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

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(we) && addr == addr  
      -> data_out == data_in);
  assert (@(posedge clk)
      addr >= 0 && addr < (1 << ADDR_WIDTH));

endmodule