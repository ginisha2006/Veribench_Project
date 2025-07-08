module tb_param_adder;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [WIDTH-1:0] sum;
logic carry;

param_adder #(.WIDTH(WIDTH)) dut (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
);

always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    ((a + b == sum) |-> (carry == (a[W-1] & b[W-1]) | (a[W-1] &!b[W-1] &!carry) | (!a[W-1] & b[W-1] & carry)));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (a[W-1] & b[W-1] | a[W-1] &!b[W-1] &!carry |!a[W-1] & b[W-1] & carry -> carry));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (!a[W-1] &!b[W-1] & carry ->!carry));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (a[W-1] & b[W-1] &!carry -> $rose(carry)));
always @(*) begin assert (@(posedge clk) disable iff (!clk); end
    (!a[W-1] &!b[W-1] & carry -> $fell(carry)));

endmodule