module tb_param_comparator;

parameter WIDTH = 8;
logic [WIDTH-1:0] A, B;
logic Equal, Greater, Less;

param_comparator #(WIDTH) dut (
   .A(A),
   .B(B),
   .Equal(Equal),
   .Greater(Greater),
   .Less(Less)
);

always @(*) begin assert (@(posedge clk); end
    ($rose(A) && $fell(B)) |-> (Equal));
always @(*) begin assert (@(posedge clk); end
    ($rose(A) && $fell(B)) |-> (Greater));
always @(*) begin assert (@(posedge clk); end
    ($rose(A) && $fell(B)) |-> (Less));
always @(*) begin assert (@(posedge clk); end
    ($rose(A) && $stable(B)) |-> (~Equal);
    ($fell(A) && $stable(B)) |-> (~Equal);
    ($rose(A) && $rose(B)) |-> (~Greater);
    ($fell(A) && $fell(B)) |-> (~Less));
always @(*) begin assert (@(posedge clk); end
    ($rose(A)[$high(A)]) |-> (~Equal);
    ($fell(A)[$low(A)]) |-> (~Equal);
    ($rose(B)[$high(B)]) |-> (~Equal);
    ($fell(B)[$low(B)]) |-> (~Equal));

endmodule