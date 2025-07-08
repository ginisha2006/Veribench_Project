module tb_param_comparator;

parameter WIDTH = 8;
reg [WIDTH-1:0] A;
reg [WIDTH-1:0] B;
wire Equal;
wire Greater;
wire Less;

param_comparator #(WIDTH) dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

always @(*) begin assert (@(posedge clk) ($rose(Equal) |-> ($onehot({A, B} == {A, B}))); end
always @(*) begin assert (@(posedge clk) ($rose(Greater) |-> (A > B))); end
always @(*) begin assert (@(posedge clk) ($rose(Less) |-> (A < B))); end
always @(*) begin assert (@(posedge clk) ((A >= 2**WIDTH - 1) |-> ($isunknown(Greater)) & ($isunknown(Less)))); end
always @(*) begin assert (@(posedge clk) ((A <= -2**WIDTH + 1) |-> ($isunknown(Less)) & ($isunknown(Greater)))); end
always @(*) begin assert (@(posedge clk) (!($isunknown(A)) &!($isunknown(B)) & (|{A, B})[WIDTH-1] && ({A, B}[WIDTH-1]) |-> ($isunknown(Equal) | $isunknown(Greater) | $isunknown(Less)))); end

endmodule