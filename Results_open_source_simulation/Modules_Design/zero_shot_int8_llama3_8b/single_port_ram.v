module single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input we,
    input clk,
    output [7:0] q
);

reg [7:0] ram [2**6-1:0];

always @(posedge clk)
begin
    if (we) ram[addr] <= data;
    q <= ram[addr];
end

endmodule