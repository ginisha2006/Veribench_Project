module param_adder #(parameter WIDTH = 8);
input [WIDTH-1:0] a;
input [WIDTH-1:0] b;
output [WIDTH-1:0] sum;
output carry;

wire [WIDTH:0] temp_sum;
assign {carry, temp_sum[WIDTH-1:0]} = {1'b0, a} + {1'b0, b};

assign sum = temp_sum[WIDTH-1:0];
endmodule