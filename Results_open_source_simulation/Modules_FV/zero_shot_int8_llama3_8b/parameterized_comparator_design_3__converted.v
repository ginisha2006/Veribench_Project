module tb_param_comparator;

parameter WIDTH = 8;
logic [WIDTH-1:0] A, B;
logic Equal, Greater, Less;
param_comparator #(WIDTH) dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

always @(*) begin assert (@(posedge clk) ($onehotb(A[WIDTH-1:0]) && $onehotb(B[WIDTH-1:0]) && Equal)); end
always @(*) begin assert (@(posedge clk) ($onehotb(A[WIDTH-1:0]) && $onehotb(B[WIDTH-1:0]) && Greater)); end
always @(*) begin assert (@(posedge clk) ($onehotb(A[WIDTH-1:0]) && $onehotb(B[WIDTH-1:0]) && Less)); end
always @(*) begin assert (@(posedge clk) ((A >= 2**WIDTH - 1) | (B >= 2**WIDTH - 1))); end
always @(*) begin assert (@(posedge clk) ((A <= -(2**WIDTH)) | (B <= -(2**WIDTH)))); end

endmodule