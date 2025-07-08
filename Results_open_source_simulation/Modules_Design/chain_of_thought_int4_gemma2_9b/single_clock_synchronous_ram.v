module ram_infer (
  input clk,
  input [5:0] read_addr,
  input [5:0] write_addr,
  input we,
  input [7:0] data,
  output reg [7:0] q
);

  always @(posedge clk) begin
    if (we) begin
      q[write_addr] <= data;
    end else begin
      q[read_addr] <= q[read_addr];
    end
  end

endmodule