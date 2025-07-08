module ram_infer (
    input wire [7:0] data,
    input wire [5:0] read_addr,
    input wire [5:0] write_addr,
    input wire we,
    input wire clk,
    output reg [7:0] q
);
    reg [7:0] mem [0:63];

    always @(posedge clk) begin
        if (we)
            mem[write_addr] <= data;
        q <= mem[read_addr];
    end
endmodule