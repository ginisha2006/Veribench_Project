module tb_ternary_adder_tree();

parameter WIDTH = 16;

logic [WIDTH-1:0] A, B, C, D, E;
logic CLK;
logic [WIDTH-1:0] OUT;

ternary_adder_tree dut (
   .A(A),
   .B(B),
   .C(C),
   .D(D),
   .E(E),
   .CLK(CLK),
   .OUT(OUT)
);

property p_sum1_valid;
    @(posedge CLK) ((|A| < 2**WIDTH) && (|B| < 2**WIDTH) && (|C| < 2**WIDTH)) => ($rose(sum1[WIDTH-1]);
endproperty

property p_sum2_valid;
    @(posedge CLK) ((|sumreg1| < 2**WIDTH) && (|D| < 2**WIDTH) && (|E| < 2**WIDTH)) => ($rose(sum2[WIDTH-1]));
endproperty

property p_out_valid;
    @(posedge CLK) ((|sumreg2| < 2**WIDTH)) => ($rose(OUT[WIDTH-1]));
endproperty

property p_overflow_sum1;
    @(posedge CLK) ((|A| >= 2**WIDTH) || (|B| >= 2**WIDTH) || (|C| >= 2**WIDTH)) |=> ($fell(sum1[WIDTH-1]));
endproperty

property p_underflow_sum1;
    @(posedge CLK) ((|A| < -2**WIDTH) || (|B| < -2**WIDTH) || (|C| < -2**WIDTH)) |=> ($fell(sum1[WIDTH-1]));
endproperty

property p_overflow_sum2;
    @(posedge CLK) ((|sumreg1| >= 2**WIDTH) || (|D| >= 2**WIDTH) || (|E| >= 2**WIDTH)) |=> ($fell(sum2[WIDTH-1]));
endproperty

property p_underflow_sum2;
    @(posedge CLK) ((|sumreg1| < -2**WIDTH) || (|D| < -2**WIDTH) || (|E| < -2**WIDTH)) |=> ($fell(sum2[WIDTH-1]));
endproperty

property p_overflow_OUT;
    @(posedge CLK) ((|sumreg2| >= 2**WIDTH)) |=> ($fell(OUT[WIDTH-1]));
endproperty

property p_underflow_OUT;
    @(posedge CLK) ((|sumreg2| < -2**WIDTH)) |=> ($fell(OUT[WIDTH-1]));
endproperty

assert property (p_sum1_valid);
assert property (p_sum2_valid);
assert property (p_out_valid);
assert property (p_overflow_sum1);
assert property (p_underflow_sum1);
assert property (p_overflow_sum2);
assert property (p_underflow_sum2);
assert property (p_overflow_OUT);
assert property (p_underflow_OUT);

endmodule