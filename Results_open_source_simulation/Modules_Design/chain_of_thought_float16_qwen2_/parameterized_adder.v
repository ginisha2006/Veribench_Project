module param_adder #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] sum,
    output carry
);
    
    wire [WIDTH:0] dsp_sum;
    
    assign {carry,sum} = dsp_sum;

    assign dsp_sum = a + b;
    
endmodule