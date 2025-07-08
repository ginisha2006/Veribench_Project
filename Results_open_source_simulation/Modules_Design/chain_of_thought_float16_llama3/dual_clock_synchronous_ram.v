module ram_dual(
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input read_clock,
    input write_clock,
    output [7:0] q
);

reg [7:0] mem [31:0];

always @(posedge read_clock)
begin
    if (we && (write_addr == read_addr))
        mem[read_addr] <= data;
end

assign q = mem[read_addr];

always @(posedge write_clock)
mem[write_addr] <= data;

endmodule