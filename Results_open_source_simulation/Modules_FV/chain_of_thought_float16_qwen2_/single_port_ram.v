module tb_single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input we,
    input clk,
    output [7:0] q
);
    
wire clk_wire;
reg clk_gen;

property posedge_clk;
 @(posedge clk) $fell(clk) |-> ##1 $rose(clk);
endproperty

assert property(posedge_clk);

property write_enable;
 @(posedge clk) (we && !data[$high(data):$low(data)]) |=> ##1 q == data;
endproperty

assert property(write_enable);

property read_enable;
 @(posedge clk) (!we && ##1 $stable(addr)) |=> ##1 q == ram[addr];
endproperty

assert property(read_enable);

property address_bounds;
 @(posedge clk) !(addr >= 64 || addr < 0);
endproperty

assert property(address_bounds);

property no_write_on_invalid_address;
 @(posedge clk) (we && (addr >= 64 || addr < 0)) |-> ##1 q != data;
endproperty

assert property(no_write_on_invalid_address);

property stable_data_during_read;
 @(posedge clk) (!we && ##1 $stable(data)) |=> ##1 q == ram[addr];
endproperty

assert property(stable_data_during_read);

property stable_addr_during_write;
 @(posedge clk) (we && ##1 $stable(addr)) |=> ##1 q == data;
endproperty

assert property(stable_addr_during_write);

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