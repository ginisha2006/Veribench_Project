module ram_infer (
    input [7:0] data,
    input [5:0] read_addr, write_addr,
    input we, clk,
    output [7:0] q
);
reg [7:0] mem [0:31];
always @(posedge clk)
if (we) mem[write_addr] <= data;
assign q = mem[read_addr];
endmodule