module ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output reg [7:0] q
);
    reg [7:0] mem [0:63];

    always @(posedge clk)
        if (we)
            mem[write_addr] <= data;

    always @* begin
        q = mem[read_addr];
    end
endmodule