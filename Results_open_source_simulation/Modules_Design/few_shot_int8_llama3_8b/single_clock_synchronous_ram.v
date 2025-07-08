module ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output [7:0] q
);
    reg [7:0] mem [32'h000000:32'h3F];
    always @(posedge clk)
        if (we) mem[write_addr] <= data;
    assign q = mem[read_addr];
endmodule