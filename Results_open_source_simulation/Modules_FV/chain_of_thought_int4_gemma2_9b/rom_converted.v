module tb_rom_simple;

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg [ADDR_WIDTH-1:0] addr;
  wire [DATA_WIDTH-1:0] data_out;

  rom_simple #(DATA_WIDTH, ADDR_WIDTH) dut (
    .addr(addr),
    .data_out(data_out)
  );

  initial begin
    $readmemh("rom_data.mem", mem);
  end

  always @(*) begin assert (@(posedge clk) addr >= 0 && addr < (1 << ADDR_WIDTH)); end
  always @(*) begin assert (@(posedge clk) data_out == mem[addr]); end

endmodule