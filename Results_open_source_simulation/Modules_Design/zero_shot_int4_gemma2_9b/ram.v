module ram_simple(
  clk,
  we,
  addr,
  data_in,
  data_out
);

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];

  assign data_out = mem[addr];

  always @(posedge clk) begin
    if (we) begin
      mem[addr] <= data_in;
    end
  end

endmodule