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

assert (@(posedge clk)
 (!we_a |-> q_a == ram[addr_a]));

assert (@(posedge clk)
 (!we_b |-> q_b == ram[addr_b]));

assert (@(posedge clk)
 (we_a && !we_b) |=> q_a == data_a);

assert (@(posedge clk)
 (we_b && !we_a) |=> q_b == data_b);

assert (@(posedge clk)
 (we_a && we_b) |-> ram[addr_a] == data_a && ram[addr_b] == data_b);

assert (@(posedge clk)
 !(addr_a >= 0 && addr_a <= 63) || !(addr_b >= 0 && addr_b <= 63) |-> q_a == 8'bX && q_b == 8'bX);

endmodule