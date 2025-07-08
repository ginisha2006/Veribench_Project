module tb_param_adder;

parameter WIDTH = 8;

logic [WIDTH-1:0] a, b;
logic [WIDTH-1:0] sum;
logic carry;

param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

always @(*) begin assert (@(posedge clk) ((a + b == sum) && (!carry))); end
always @(*) begin assert (@(posedge clk) (carry == (a[WIDTH-1] & ~b[WIDTH-1]) | (~a[WIDTH-1] & b[WIDTH-1]))); end
always @(*) begin assert (@(posedge clk) (carry == (sum[WIDTH-1] & ~sum[WIDTH-2]) | (~sum[WIDTH-1] & sum[WIDTH-2]))); end
always @(*) begin assert (@(posedge clk) ($rose(carry) | $fell(carry))); end
always @(*) begin assert (@(posedge clk) ($fell(carry) | $rose(carry))); end
always @(*) begin assert (@(posedge clk) ((a == 0) | (b == 0) | (a == b) | (a == ~b))); end

endmodule