module ram_dual (
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we, read_clock, write_clock,
    output reg [7:0] q
);

  always @(posedge read_clock) begin
    if(we) begin
      q <= data;
    end
  end

endmodule