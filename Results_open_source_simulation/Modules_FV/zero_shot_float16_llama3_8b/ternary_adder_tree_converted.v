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

always @(*) begin assert (@(posedge CLK) ((|A| < 2**WIDTH) && (|B| < 2**WIDTH) && (|C| < 2**WIDTH)) => ($rose(sum1[WIDTH-1])); end
always @(*) begin assert (@(posedge CLK) ((|sumreg1| < 2**WIDTH) && (|D| < 2**WIDTH) && (|E| < 2**WIDTH)) => ($rose(sum2[WIDTH-1]))); end
always @(*) begin assert (@(posedge CLK) ((|sumreg2| < 2**WIDTH)) => ($rose(OUT[WIDTH-1]))); end
always @(*) begin assert (@(posedge CLK) ((|A| >= 2**WIDTH) || (|B| >= 2**WIDTH) || (|C| >= 2**WIDTH)) |=> ($fell(sum1[WIDTH-1]))); end
always @(*) begin assert (@(posedge CLK) ((|A| < -2**WIDTH) || (|B| < -2**WIDTH) || (|C| < -2**WIDTH)) |=> ($fell(sum1[WIDTH-1]))); end
always @(*) begin assert (@(posedge CLK) ((|sumreg1| >= 2**WIDTH) || (|D| >= 2**WIDTH) || (|E| >= 2**WIDTH)) |=> ($fell(sum2[WIDTH-1]))); end
always @(*) begin assert (@(posedge CLK) ((|sumreg1| < -2**WIDTH) || (|D| < -2**WIDTH) || (|E| < -2**WIDTH)) |=> ($fell(sum2[WIDTH-1]))); end
always @(*) begin assert (@(posedge CLK) ((|sumreg2| >= 2**WIDTH)) |=> ($fell(OUT[WIDTH-1]))); end
always @(*) begin assert (@(posedge CLK) ((|sumreg2| < -2**WIDTH)) |=> ($fell(OUT[WIDTH-1]))); end

endmodule