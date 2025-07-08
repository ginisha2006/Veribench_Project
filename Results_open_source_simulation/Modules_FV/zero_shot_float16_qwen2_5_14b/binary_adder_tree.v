module tb_binary_adder_tree(
    input [15:0] A,
    input [15:0] B,
    input [15:0] C,
    input [15:0] D,
    input [15:0] E,
    input clk,
    output reg [15:0] out
);
    
wire [15:0] sum1, sum2, sum3, sum4;
reg [15:0] sumreg1, sumreg2, sumreg3, sumreg4;

binary_adder_tree dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .clk(clk),
    .out(out)
);

always #5 clk =~clk;

property posedge_clk;
 @(posedge clk) inside($past(sumreg1), 0, 65535) |-> inside(sumreg1, 0, 65535);
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) inside($past(sumreg2), 0, 65535) |-> inside(sumreg2, 0, 65535);
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) inside($past(sumreg3), 0, 65535) |-> inside(sumreg3, 0, 65535);
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) inside($past(sumreg4), 0, 65535) |-> inside(sumreg4, 0, 65535);
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) out == sumreg4;
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) sum1 == A + B;
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) sum2 == C + D;
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) sum3 == sumreg1 + sumreg2;
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) sum4 == sumreg3 + E;
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) sumreg1 == sum1;
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) sumreg2 == sum2;
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) sumreg3 == sum3;
endproperty
assert property(posedge_clk);

property posedge_clk;
 @(posedge clk) sumreg4 == sum4;
endproperty
assert property(posedge_clk);

endmodule