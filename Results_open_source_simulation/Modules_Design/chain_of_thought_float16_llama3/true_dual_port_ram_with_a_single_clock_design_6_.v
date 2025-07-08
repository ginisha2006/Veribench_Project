module true_dpram_sclk(
    input [7:0] data_a,
    input [7:0] data_b,
    input [5:0] addr_a,
    input [5:0] addr_b,
    input we_a,
    input we_b,
    input clk,
    output [7:0] q_a,
    output [7:0] q_b
);

reg [15:0] ram [31:0];

always @(posedge clk) begin
    if (we_a) ram[addr_a] <= #1 data_a;
    if (we_b) ram[addr_b] <= #1 data_b;
end

assign q_a = (we_a)? ram[addr_a][7:0] : 'bz;
assign q_b = (we_b)? ram[addr_b][7:0] : 'bz;

endmodule