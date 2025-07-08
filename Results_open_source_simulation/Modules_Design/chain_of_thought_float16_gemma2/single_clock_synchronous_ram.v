module ram_infer (
  input clk,
  input we,
  input [5:0] read_addr,
  input [5:0] write_addr,
  input [7:0] data,
  output reg [7:0] q
);

  reg [7:0] ram [0:31];

  always @(posedge clk) begin
    if (we) begin
      ram[write_addr] <= data;
    end
  end

  always @(posedge clk) begin
    q <= ram[read_addr];
  end

endmodule