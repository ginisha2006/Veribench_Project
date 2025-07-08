module tb_param_multiplier;

parameter WIDTH = 8;

input [WIDTH-1:0] a;

input [WIDTH-1:0] b;

output [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.product(product));

property multiplier_correctness;

@(posedge clk) ($rose(a) |-> $rose(b) |=> $rose(product));

property overflow_check;

@(posedge clk) ((a == 2**WIDTH - 1) | (b == 2**WIDTH - 1)) |=> ($isunknown(product[WIDTH-1]));

property underflow_check;

@(posedge clk) ((a == 0) & (b!= 0)) |=> ($isunknown(product[WIDTH-1]));

property zero_product;

@(posedge clk) ((a == 0) | (b == 0)) |=> (product == 0);

property non_zero_product;

@(posedge clk) (~(a == 0) & ~(b == 0)) |=> (~($isunknown(product[WIDTH-1])));

always #10 clk = ~clk;

initial begin

#20 clk <= 1'b1;

#100 $finish;

end

endmodule