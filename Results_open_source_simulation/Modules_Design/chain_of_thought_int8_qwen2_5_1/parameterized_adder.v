module param_adder #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [WIDTH-1:0] sum,
    output reg carry
);
    
    wire [WIDTH:0] dsp_sum;
    
    assign {carry,dsp_sum[WIDTH-1:0]} = a + b;

    always @(*) begin
        sum = dsp_sum[WIDTH-1:0];
    end
    
endmodule