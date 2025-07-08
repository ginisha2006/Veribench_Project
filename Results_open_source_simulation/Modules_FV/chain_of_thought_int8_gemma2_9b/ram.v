module tb_ram_simple(
);
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
  
  property write_access;
    @(posedge clk)
      $past(we) == 1 && we == 1 && addr >= 0 && addr < (1<<ADDR_WIDTH)
      -> data_out == data_in;
  endproperty
  
  assert property(write_access);

  property read_access;
    @(posedge clk)
      $past(we) == 0 && we == 0 && addr >= 0 && addr < (1<<ADDR_WIDTH)
      -> data_out == mem[addr];
  endproperty
  
  assert property(read_access);

endmodule