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

property no_overflow;
 @(posedge clk) disable iff (!reset)
   ({1'b0,a} - b)[WIDTH] == 1'b0;
endproperty

assert property(no_overflow);

property no_underflow;
 @(posedge clk) disable iff (!reset)
   ({1'b0,a} >= b);
endproperty

assert property(no_underflow);

property correct_diff;
 @(posedge clk) disable iff (!reset)
   diff === (a - b);
endproperty

assert property(correct_diff);

property borrow_correct;
 @(posedge clk) disable iff (!reset)
   borrow === ({1'b0,a} < b)[WIDTH];
endproperty

assert property(borrow_correct);

endmodule