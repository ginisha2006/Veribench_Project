module tb_true_dpram_sclk (
    input [7:0] data_a, data_b,
    input [5:0] addr_a, addr_b,
    input we_a, we_b,
    input clk,
    output reg [7:0] q_a, q_b
);

reg [7:0] ram[63:0];

assert (@(posedge clk) disable iff (!clk)
        addr_a inside {[0:63]} |-> ##1 $stable(addr_a);
    @(posedge clk) disable iff (!clk)
        addr_b inside {[0:63]} |-> ##1 $stable(addr_b));

assert (@(posedge clk) disable iff (!clk)
        we_a |=> ##1 $stable(we_a);
    @(posedge clk) disable iff (!clk)
        we_b |=> ##1 $stable(we_b));

assert (@(posedge clk) disable iff (!clk)
        we_a && !we_b |-> ##1 q_a == data_a;
    @(posedge clk) disable iff (!clk)
        we_b && !we_a |-> ##1 q_b == data_b;
    @(posedge clk) disable iff (!clk)
        we_a && we_b |-> ##1 {q_a,q_b} inside {{data_a},{data_b}});

assert (@(posedge clk) disable iff (!clk)
        we_a && ##1 !we_a |-> ##1 q_a == data_a;
    @(posedge clk) disable iff (!clk)
        we_b && ##1 !we_b |-> ##1 q_b == data_b);

assert (@(posedge clk) disable iff (!clk)
        we_a && we_b && addr_a == addr_b |-> ##1 {q_a,q_b} inside {{data_a},{data_b}});

assert (@(negedge clk) disable iff (!clk)
        !we_a && !we_b |-> q_a == 8'b0 && q_b == 8'b0);

endmodule