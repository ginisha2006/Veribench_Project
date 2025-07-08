module ram_dual (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input read_clock,
    input write_clock,
    output reg [7:0] q
);
reg [7:0] mem [0:63];

always @(posedge write_clock) begin
    if (we)
        mem[write_addr] <= data;
end

always @(posedge read_clock) begin
    q <= mem[read_addr];
end
endmodule