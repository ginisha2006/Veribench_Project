module ram_dual (
  data,
  read_addr,
  write_addr,
  we,
  read_clock,
  write_clock,
  q
);

  input [7:0] data;
  input [5:0] read_addr;
  input [5:0] write_addr;
  input we;
  input read_clock;
  input write_clock;
  output [7:0] q;

  reg [7:0] mem [0:31];

  always @(posedge read_clock) begin
    if (we) begin
      mem[write_addr] <= data;
    end
  end

  always @(posedge write_clock) begin
    if (we) begin
      mem[write_addr] <= data;
    end
  end

  assign q = mem[read_addr];

endmodule