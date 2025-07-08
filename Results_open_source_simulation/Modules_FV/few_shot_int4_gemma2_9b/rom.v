module tb_rom_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8)();

  // Inputs
  reg [ADDR_WIDTH-1:0] addr;
  
  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the ROM
  rom_simple #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  ) UUT (
    .addr(addr),
    .data_out(data_out)
  );

  // Address range for property evaluation
  initial begin
    addr = 0;
    repeat((1 << ADDR_WIDTH)) begin
      #1 addr = addr + 1;
    end
  end

  // Property: Check if data_out matches expected values from rom_data.mem
  property p_correct_data;
    @(posedge clk) (data_out == mem[addr]);
  endproperty
  assert property (p_correct_data);

endmodule