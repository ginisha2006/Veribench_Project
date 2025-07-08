module tb_ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output reg [7:0] q
);
reg [7:0] ram[63:0];

always #5 clk = ~clk;

always @(*) begin assert (@(posedge clk) !($isunknown(clk)) |-> clk == 1'b1); end

always @(*) begin assert (@(posedge clk) (we && write_addr < 64) |=> ##1 ram[write_addr] == data); end

always @(*) begin assert (@(posedge clk) (!we && read_addr < 64) |=> ##1 q == ram[read_addr]); end

always @(*) begin assert (@(posedge clk) (write_addr >= 64 || read_addr >= 64) |-> $isunknown(q)); end

always @(*) begin assert (@(posedge clk) (we && write_addr == read_addr) |-> ##1 q == data); end

always @(*) begin assert (@(posedge clk) (!we && write_addr != read_addr) |=> ##1 q == ram[read_addr]); end

endmodule