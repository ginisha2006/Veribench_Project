module tb_binary_adder_tree();

parameter WIDTH = 16;

logic [WIDTH-1:0] A, B, C, D, E;
logic clk;
logic [WIDTH-1:0] out;

binary_adder_tree dut (
   .A(A),
   .B(B),
   .C(C),
   .D(D),
   .E(E),
   .clk(clk),
   .out(out)
);

property p_sum1_valid;
    @(posedge clk) disable iff (!clk) ((A == 0) | (B == 0)) => ($onehot(A + B));
endproperty

property p_sum2_valid;
    @(posedge clk) disable iff (!clk) ((C == 0) | (D == 0)) => ($onehot(C + D));
endproperty

property p_sum3_valid;
    @(posedge clk) disable iff (!clk) ((sum1 == 0) | (sum2 == 0)) => ($onehot(sum1 + sum2));
endproperty

property p_sum4_valid;
    @(posedge clk) disable iff (!clk) ((sum3 == 0) | (E == 0)) => ($onehot(sum3 + E));
endproperty

property p_out_valid;
    @(posedge clk) disable iff (!clk) ($onehot(out));
endproperty

property p_overflow;
    @(posedge clk) disable iff (!clk) ((A + B > 2**WIDTH - 1) | (C + D > 2**WIDTH - 1) | (sum1 + sum2 > 2**WIDTH - 1) | (sum3 + E > 2**WIDTH - 1));
endproperty

property p_underflow;
    @(posedge clk) disable iff (!clk) ((A + B < 2**WIDTH - 1) | (C + D < 2**WIDTH - 1) | (sum1 + sum2 < 2**WIDTH - 1) | (sum3 + E < 2**WIDTH - 1));
endproperty

assert property (p_sum1_valid);
assert property (p_sum2_valid);
assert property (p_sum3_valid);
assert property (p_sum4_valid);
assert property (p_out_valid);
assert property (~p_overflow);
assert property (~p_underflow);

always #10 clk = ~clk; // Clock generation

initial begin
    clk = 0;
    repeat (100) @(posedge clk); // Run for 100 cycles
end

endmodule