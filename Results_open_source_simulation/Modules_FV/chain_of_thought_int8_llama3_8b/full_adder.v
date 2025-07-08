module tb_full_adder;

parameter CLOCK_PERIOD = 10;

reg clk;

wire [1:0] a, b;

wire cin;

wire sum, cout;

full_adder dut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

always #CLOCK_PERIOD/2 clk = ~clk;

property p_sum_correct;

@(posedge clk) ($onehotb(a) && $onehotb(b) && $onehot(cin) => assert (sum == (a ^ b ^ cin)));

property p_cout_correct;

@(posedge clk) ($onehotb(a) && $onehotb(b) && $onehot(cin) => assert (cout == ((a & b) | (b & cin) | (a & cin))));

property p_edge_cases;

@(posedge clk) disable iff (!clk) ($fell(a) && $rose(b) && $stable(cin) => assert (~cout));

@(posedge clk) disable iff (!clk) ($fell(b) && $rose(a) && $stable(cin) => assert (~cout));

@(posedge clk) disable iff (!clk) ($fell(cin) && $rose(a) && $stable(b) => assert (~cout));

@(posedge clk) disable iff (!clk) ($fell(cin) && $rose(b) && $stable(a) => assert (~cout));

property p_overflow;

@(posedge clk) ($onehotb(a) && $onehotb(b) && $onehot(cin) && (a == 1'b1 && b == 1'b1 && cin == 1'b1) => assert (cout == 1'b1));

property p_underflow;

@(posedge clk) ($onehotb(a) && $onehotb(b) && $onehot(cin) && (a == 1'b0 && b == 1'b0 && cin == 1'b0) => assert (cout == 1'b0));

initial begin

#5 clk = 1'b0;

#CLOCK_PERIOD/2 clk = 1'b1;

#CLOCK_PERIOD*2 $finish;

end

endmodule