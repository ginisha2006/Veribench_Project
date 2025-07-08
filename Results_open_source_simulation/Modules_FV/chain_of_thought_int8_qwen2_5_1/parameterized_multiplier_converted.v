module tb_param_multiplier(
    input [7:0] a,
    input [7:0] b,
    output reg [15:0] clk,
    output [15:0] product
);

reg [7:0] a_int;
reg [7:0] b_int;

param_multiplier #(.WIDTH(8)) dut (
    .a(a),
    .b(b),
    .product(product)
);

always begin
    clk = 0; #5;
    clk = 1; #5;
end

always @(*) begin assert (@(posedge clk) disable iff (!clk) (a !== a[int']) |-> ##[1:$] (a == a[int'])); end

always @(*) begin assert (@(posedge clk) disable iff (!clk) (a * b === product)); end

assert (@(posedge clk) disable iff (!clk) ((a == 8'b0 && b != 8'b0) |-> (product == 8'b0))
      and ((a != 8'b0 && b == 8'b0) |-> (product == 8'b0)));

always @(*) begin assert (@(posedge clk) disable iff (!clk) ((a > 8'hFF / b || b > 8'hFF / a) && (a != 8'b0 && b != 8'b0)) |-> (product != a * b)); end

endmodule