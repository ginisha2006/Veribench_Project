module tb_single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input we,
    input clk,
    output [7:0] q
);
    
wire clk_wire;
reg clk_gen;

always @(*) begin assert (@(posedge clk) $fell(clk) |-> ##1 $rose(clk)); end

always @(*) begin assert (@(posedge clk) (we && !data[$high(data):$low(data)]) |=> ##1 q == data); end

always @(*) begin assert (@(posedge clk) (!we && ##1 $stable(addr)) |=> ##1 q == ram[addr]); end

always @(*) begin assert (@(posedge clk) !(addr >= 64 || addr < 0)); end

always @(*) begin assert (@(posedge clk) (we && (addr >= 64 || addr < 0)) |-> ##1 q != data); end

always @(*) begin assert (@(posedge clk) (!we && ##1 $stable(data)) |=> ##1 q == ram[addr]); end

always @(*) begin assert (@(posedge clk) (we && ##1 $stable(addr)) |=> ##1 q == data); end

always begin
    clk_gen = 1'b0; #5;
    clk_gen = 1'b1; #5;
end

assign clk = clk_gen;

single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
);

endmodule