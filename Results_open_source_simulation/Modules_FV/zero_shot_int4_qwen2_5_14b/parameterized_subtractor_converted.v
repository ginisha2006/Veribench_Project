module tb_param_subtractor;

parameter WIDTH = 8;

logic [WIDTH-1:0] a;
logic [WIDTH-1:0] b;
logic [WIDTH-1:0] diff;
logic borrow;
logic clk;

param_subtractor #(.WIDTH(WIDTH)) uut (
    .a(a),
    .b(b),
    .diff(diff),
    .borrow(borrow)
);

always begin
    clk = 1; #5; clk = 0; #5;
end

assert (@(posedge clk) disable iff (!reset)
   ({1'b0,a} - b)[WIDTH] == 1'b0);

assert (@(posedge clk) disable iff (!reset)
   ({1'b0,a} >= b));

assert (@(posedge clk) disable iff (!reset)
   diff === (a - b));

assert (@(posedge clk) disable iff (!reset)
   borrow === ({1'b0,a} < b)[WIDTH]);

endmodule