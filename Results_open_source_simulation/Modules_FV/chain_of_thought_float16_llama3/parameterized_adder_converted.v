module tb_param_adder;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [WIDTH-1:0] sum;
logic carry;

param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

always @(*) begin assert (@(posedge clk) ((a + b == sum) |-> (!carry))); end
always @(*) begin assert (@(posedge clk) ((a[WIDTH-1] &&!b[WIDTH-1]) | (b[WIDTH-1] &&!a[WIDTH-1]) | (a[WIDTH-1] && b[WIDTH-1])) |-> carry); end
always @(*) begin assert (@(posedge clk) (!((a[WIDTH-1] &&!b[WIDTH-1]) | (b[WIDTH-1] &&!a[WIDTH-1]) | (a[WIDTH-1] && b[WIDTH-1]))) |->!carry); end
always @(*) begin assert (@(posedge clk) ((a == (1 << WIDTH)-1) && (b!= 0)) |-> (sum == (1 << WIDTH)-1)); end
always @(*) begin assert (@(posedge clk) ((a == 0) && (b == (1 << WIDTH)-1)) |-> (sum == 0)); end

endmodule