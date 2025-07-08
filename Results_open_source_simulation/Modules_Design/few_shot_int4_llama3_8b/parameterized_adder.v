module param_adder #(parameter WIDTH=8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [WIDTH-1:0] sum,
    output reg carry
);
    wire [WIDTH:0] temp_sum;

    always @* begin
        {carry, sum} = temp_sum[WIDTH-1:0];
    end

    always @(a or b) begin
        temp_sum = a + b;
    end
endmodule