module tb_ram_simple(
  );

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  logic clk;
  logic we;
  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;

  ram_simple dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #5 clk = ~clk;

  assert (@(posedge clk)
      $past(we) && addr != 0 && data_in != 0
      -> data_out == data_in);

endmodule