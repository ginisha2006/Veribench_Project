module single_port_ram;
input [7:0] data;
input [5:0] addr;
input we, clk;
output reg [7:0] q;

reg [7:0] ram [31 downto 0];

always @(posedge clk)
begin
if (we) begin
ram[addr] <= data;
end
q <= ram[addr];
end
endmodule