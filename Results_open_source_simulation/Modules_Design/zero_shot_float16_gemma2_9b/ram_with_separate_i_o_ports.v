module ram_separate_io (
  clk,
  we,
  addr,
  data_in,
  data_out
) (
  input clk,
  input we,
  input [ADDR_WIDTH-1:0] addr,
  input [DATA_WIDTH-1:0] data_in,
  output [DATA_WIDTH-1:0] data_out
);

  reg [DATA_WIDTH-1:0] mem [0:255];

  always @(posedge clk) begin
    if (we) begin
      mem[addr] <= data_in;
    end
  end

  assign data_out = mem[addr];

endmodule