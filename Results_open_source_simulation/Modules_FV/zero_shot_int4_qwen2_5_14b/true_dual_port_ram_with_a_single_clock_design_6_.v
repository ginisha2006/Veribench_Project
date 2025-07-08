module tb_true_dpram_sclk (
    input [7:0] data_a, data_b,
    input [5:0] addr_a, addr_b,
    input we_a, we_b,
    input clk,
    output reg [7:0] q_a, q_b
);

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

reg clk = 0;

always #10 clk = ~clk;

property prop_clk_non_zero;
 @(posedge clk) disable iff (!reset) clk !== 0;
endproperty

assert property(prop_clk_non_zero);

property prop_q_a_read_write;
 @(posedge clk) disable iff (!reset) (we_a && !we_b) |=> q_a == data_a;
endproperty

assert property(prop_q_a_read_write);

property prop_q_b_read_write;
 @(posedge clk) disable iff (!reset) (we_b && !we_a) |=> q_b == data_b;
endproperty

assert property(prop_q_b_read_write);

property prop_ram_consistency;
 @(posedge clk) disable iff (!reset) (we_a || we_b) |-> (addr_a == addr_b) ? (q_a == data_a && q_b == data_b) : ((addr_a != addr_b) && (q_a == ram[addr_a]) && (q_b == ram[addr_b]));
endproperty

assert property(prop_ram_consistency);

property prop_no_over_under_flow;
 @(posedge clk) disable iff (!reset) !(addr_a > 63) && !(addr_b > 63);
endproperty

assert property(prop_no_over_under_flow);

endmodule