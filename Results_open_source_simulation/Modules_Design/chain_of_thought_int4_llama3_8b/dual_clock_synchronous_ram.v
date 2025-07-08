module ram_dual (data, read_addr, write_addr, we, read_clock, write_clock, q);

input [7:0] data;

input [5:0] read_addr, write_addr;

input we, read_clock, write_clock;

output reg [7:0] q;

reg [7:0] mem [0:(1 << 6) - 1];

always @(posedge read_clock) begin

q <= mem[read_addr];

end

always @(posedge write_clock) begin

if (we) mem[write_addr] <= data;

end

endmodule