module single_port_ram (
    input wire [7:0] data,
    input wire [5:0] addr,
    input wire we,
    input wire clk,
    output reg [7:0] q
);
    reg [7:0] mem [0:63];

    always @(posedge clk) begin
        if (we)
            mem[addr] <= data;
        q <= mem[addr];
    end
endmodule