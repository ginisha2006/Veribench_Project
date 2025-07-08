module true_dpram_sclk(
    input [7:0] data_a,
    input [7:0] data_b,
    input [5:0] addr_a,
    input [5:0] addr_b,
    input we_a,
    input we_b,
    input clk,
    output reg [7:0] q_a,
    output reg [7:0] q_b
);

reg [15:0] ram [31 downto 0];

always @(posedge clk) begin
    if (we_a &&!addr_a == addr_b)
        ram[addr_a] <= data_a;
    else if (!we_a && addr_a == addr_b)
        q_a <= ram[addr_a];
    if (we_b &&!addr_b!= addr_a)
        ram[addr_b] <= data_b;
    else if (!we_b && addr_b!= addr_a)
        q_b <= ram[addr_b];
end

assign q_a = ram[addr_a];
assign q_b = ram[addr_b];

endmodule