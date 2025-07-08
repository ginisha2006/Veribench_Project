module true_dpram_sclk (
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

reg [7:0] mem [0:63];

always @(posedge clk)
begin
    if (we_a)
        mem[addr_a] <= data_a;
    if (we_b)
        mem[addr_b] <= data_b;

    q_a <= mem[addr_a];
    q_b <= mem[addr_b];
end

endmodule