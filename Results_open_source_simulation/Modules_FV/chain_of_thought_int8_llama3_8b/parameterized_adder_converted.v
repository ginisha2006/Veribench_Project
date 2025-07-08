module tb_param_adder;

parameter WIDTH = 8;

input [WIDTH-1:0] a, b;

output [WIDTH-1:0] sum;

output carry;

param_adder #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.sum(sum),.carry(carry));

initial begin

#10 rst_n = 1'b0;

#20 rst_n = 1'b1;

#100 $finish;

end

endmodule