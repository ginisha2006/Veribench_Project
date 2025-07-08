module ram_dual;
input [7:0] data;
input [5:0] read_addr, write_addr;
input we, read_clock, write_clock;
output [7:0] q;

reg [7:0] mem [0:31];

always @(posedge read_clock) begin
    if (read_addr!= 0) q <= mem[read_addr];
end

always @(posedge write_clock) begin
    if (we) mem[write_addr] <= data;
end

endmodule