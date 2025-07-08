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

always @(*) begin assert (@(posedge clk) (we && $past(!we)) |-> q == data after 1); end

always @(*) begin assert (@(posedge clk) (!we && $past(we)) |-> q == $past(q)); end

always @(*) begin assert (@(posedge clk) !(addr >= 64 || addr < 0)); end

assert (reg [7:0] prev_data;
 reg [5:0] prev_addr;
 @(posedge clk) (we && addr === prev_addr) |-> ##1 q !== prev_data);

assert (reg [7:0] prev_data;
 reg [5:0] prev_addr;
 @(posedge clk) (we && addr === prev_addr && !we) |-> q == prev_data);

always #10 clk_gen = ~clk_gen;
assign clk = clk_gen;

single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
);

endmodule