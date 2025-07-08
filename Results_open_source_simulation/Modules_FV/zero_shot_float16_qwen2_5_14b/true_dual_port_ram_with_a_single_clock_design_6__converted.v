module tb_true_dpram_sclk (
    input [7:0] data_a_i,
    input [7:0] data_b_i,
    input [5:0] addr_a_i,
    input [5:0] addr_b_i,
    input we_a_i,
    input we_b_i,
    input clk_i,
    output reg [7:0] q_a_o,
    output reg [7:0] q_b_o
);

reg [7:0] ram[63:0];

true_dpram_sclk dut (
    .data_a(data_a_i),
    .data_b(data_b_i),
    .addr_a(addr_a_i),
    .addr_b(addr_b_i),
    .we_a(we_a_i),
    .we_b(we_b_i),
    .clk(clk_i),
    .q_a(q_a_o),
    .q_b(q_b_o)
);

always #10 clk_i = ~clk_i;

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) !($isunknown({data_a_i, data_b_i, addr_a_i, addr_b_i, we_a_i, we_b_i}))); end

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) !(addr_a_i < 0 || addr_a_i > 63)); end

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) !(addr_b_i < 0 || addr_b_i > 63)); end

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) !we_a_i |=> q_a_o == data_a_i); end

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) we_a_i |-> ram[addr_a_i] == data_a_i); end

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) !we_b_i |=> q_b_o == data_b_i); end

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) we_b_i |-> ram[addr_b_i] == data_b_i); end

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) (addr_a_i == addr_b_i && we_a_i && we_b_i) |-> q_a_o == q_b_o); end

always @(*) begin assert (@(posedge clk_i) disable iff (!clk_i) (addr_a_i == addr_b_i && we_a_i && we_b_i) |-> $past(we_a_i != we_b_i)); end

endmodule