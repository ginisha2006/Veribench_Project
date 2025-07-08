module ram_infer(clk, we, read_addr, write_addr, data, q);

input [7:0] data;

input [5:0] read_addr, write_addr;

input clk, we;

output reg [7:0] q;

reg [15:0] mem [0:(1<<6)-1];

always @(posedge clk) begin

if (we) mem[write_addr] <= data;

q <= mem[read_addr];

end

endmodule