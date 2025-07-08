module tb_binary_adder_tree;

parameter CLOCK_PERIOD = 10;

logic [15:0] A, B, C, D, E;

logic clk;

logic [15:0] out;

binary_adder_tree dut (.A(A),.B(B),.C(C),.D(D),.E(E),.clk(clk),.out(out));

always @(*) begin assert (@(posedge clk) disable iff (!clk) ($rose(A) | $rose(B)) => ($distinct(A, B))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ($rose(C) | $rose(D)) => ($distinct(C, D))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ($rose(sumreg1) | $rose(sumreg2)) => ($distinct(sumreg1, sumreg2))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ($rose(sumreg3) | $rose(E)) => ($distinct(sumreg3, E))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ($rose(out)) => ($distinct(out))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((A == 16'h7FFF) && (B == 16'h8000)) | ((C == 16'h7FFF) && (D == 16'h8000)) | ((sumreg1 == 16'hFFFF) && (sumreg2 == 16'h10000)) | ((sumreg3 == 16'hFFFF) && (E == 16'h10000)) => ($rose(out))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((A == 16'h0000) && (B == 16'h8000)) | ((C == 16'h0000) && (D == 16'h8000)) | ((sumreg1 == 16'h0000) && (sumreg2 == 16'h10000)) | ((sumreg3 == 16'h0000) && (E == 16'h10000)) => ($fell(out))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((A == 16'h0000) && (B == 16'h0000)) | ((C == 16'h0000) && (D == 16'h0000)) | ((E == 16'h0000)) => ($stable(out))); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((A!= 16'h0000) && (B!= 16'h0000) && (C!= 16'h0000) && (D!= 16'h0000) && (E!= 16'h0000)) => ($stable(out))); end

always #CLOCK_PERIOD clk = ~clk;

initial begin

#20 clk = 1'b1;

repeat(100)

#CLOCK_PERIOD clk = ~clk;

#20 clk = 1'b1;

$finish;

end

endmodule