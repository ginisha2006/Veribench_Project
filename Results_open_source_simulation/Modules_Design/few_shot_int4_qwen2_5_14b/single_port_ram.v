module single_port_ram (
    input wire [7:0] data,
    input wire [5:0] addr,
    input wire we,
    input wire clk,
    output reg [7:0] q
);
    reg [7:0] mem [63:0];

    always @(posedge clk)
        if (we)
            mem[addr] <= data;

    always @(addr)
        q <= mem[addr];
endmodule