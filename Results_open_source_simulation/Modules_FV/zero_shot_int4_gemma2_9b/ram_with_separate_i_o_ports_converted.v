module tb_ram_separate_io;

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;

  ram_separate_io dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(we) && !we ? data_out == ram[addr] : true);
  assert (@(posedge clk)
      !we && data_out == ram[addr]);
  assert (@(posedge clk)
      0 <= addr && addr < 2**ADDR_WIDTH);

endmodule