module tb_rom_simple;

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg [ADDR_WIDTH-1:0] addr;
  wire [DATA_WIDTH-1:0] data_out;

  rom_simple dut (
    .addr(addr),
    .data_out(data_out)
  );

  initial begin
    addr_prev = 0;
    forever #5 addr = addr + 1;
  end

  always @(posedge clk) begin
    addr_prev <= addr;
  end

  always @(*) begin assert (@(posedge clk) addr != addr_prev && data_out == mem[addr]); end
  always @(*) begin assert (0 <= addr && addr < (1 << ADDR_WIDTH)); end

endmodule