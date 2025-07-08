module tb_true_dpram_sclk (
    input [7:0] data_a, data_b,
    input [5:0] addr_a, addr_b,
    input we_a, we_b,
    input clk,
    output reg [7:0] q_a, q_b
);

reg [7:0] ram[63:0];

true_dpram_sclk dut (
    .data_a(data_a),
    .data_b(data_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .clk(clk),
    .q_a(q_a),
    .q_b(q_b)
);

always begin
    clk = 0; #5; clk = 1; #5;
end

property read_write_consistency_a;
 @(posedge clk)
 (!we_a |-> q_a == ram[addr_a]);
endproperty

assert property(read_write_consistency_a);

property read_write_consistency_b;
 @(posedge clk)
 (!we_b |-> q_b == ram[addr_b]);
endproperty

assert property(read_write_consistency_b);

property write_update_a;
 @(posedge clk)
 (we_a && !we_b) |=> q_a == data_a;
endproperty

assert property(write_update_a);

property write_update_b;
 @(posedge clk)
 (we_b && !we_a) |=> q_b == data_b;
endproperty

assert property(write_update_b);

property concurrent_writes;
 @(posedge clk)
 (we_a && we_b) |-> ram[addr_a] == data_a && ram[addr_b] == data_b;
endproperty

assert property(concurrent_writes);

property address_out_of_bounds;
 @(posedge clk)
 !(addr_a >= 0 && addr_a <= 63) || !(addr_b >= 0 && addr_b <= 63) |-> q_a == 8'bX && q_b == 8'bX;
endproperty

assert property(address_out_of_bounds);

endmodule