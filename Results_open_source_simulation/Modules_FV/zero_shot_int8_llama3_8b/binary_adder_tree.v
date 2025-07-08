module tb_binary_adder_tree;

parameter CLOCK_PERIOD = 10;

logic [15:0] A, B, C, D, E;

logic clk;

logic [15:0] out;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

property p_sum1_valid; @(posedge clk) disable iff (!clk) ($rose(A) | $rose(B)) => ($distinct(A, B)); endproperty

property p_sum2_valid; @(posedge clk) disable iff (!clk) ($rose(C) | $rose(D)) => ($distinct(C, D)); endproperty

property p_sum3_valid; @(posedge clk) disable iff (!clk) ($rose(sumreg1) | $rose(sumreg2)) => ($distinct(sumreg1, sumreg2)); endproperty

property p_sum4_valid; @(posedge clk) disable iff (!clk) ($rose(sumreg3) | $rose(E)) => ($distinct(sumreg3, E)); endproperty

property p_out_valid; @(posedge clk) disable iff (!clk) ($rose(out)) => ($distinct(out)); endproperty

property p_overflow; @(posedge clk) disable iff (!clk) ((A == 16'h7FFF) && (B == 16'h8000)) | ((C == 16'h7FFF) && (D == 16'h8000)) | ((sumreg1 == 16'hFFFF) && (sumreg2 == 16'h10000)) | ((sumreg3 == 16'hFFFF) && (E == 16'h10000)) => ($rose(out)); endproperty

property p_underflow; @(posedge clk) disable iff (!clk) ((A == 16'h0000) && (B == 16'h8000)) | ((C == 16'h0000) && (D == 16'h8000)) | ((sumreg1 == 16'h0000) && (sumreg2 == 16'h10000)) | ((sumreg3 == 16'h0000) && (E == 16'h10000)) => ($fell(out)); endproperty

property p_edge_cases; @(posedge clk) disable iff (!clk) ((A == 16'h0000) && (B == 16'h0000)) | ((C == 16'h0000) && (D == 16'h0000)) | ((E == 16'h0000)) => ($stable(out)); endproperty

property p_illegal_transition; @(posedge clk) disable iff (!clk) ((A!= 16'h0000) && (B!= 16'h0000) && (C!= 16'h0000) && (D!= 16'h0000) && (E!= 16'h0000)) => ($stable(out)); endproperty

assert property (p_sum1_valid);

assert property (p_sum2_valid);

assert property (p_sum3_valid);

assert property (p_sum4_valid);

assert property (p_out_valid);

assert property (p_overflow);

assert property (p_underflow);

assert property (p_edge_cases);

assert property (p_illegal_transition);

always #CLOCK_PERIOD clk = ~clk;

initial begin

#20 clk = 1'b1;

repeat(100)

#CLOCK_PERIOD clk = ~clk;

#20 clk = 1'b1;

$finish;

end

endmodule