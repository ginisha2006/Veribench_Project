module param_adder #(
    parameter WIDTH=8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [WIDTH-1:0] sum,
    output reg carry
);

    generate
        if(WIDTH > 1)
            initial begin
                integer i;
                for(i=0; i<WIDTH; i=i+1) begin
                    always @(a[i] or b[i]) begin
                        sum[i] <= a[i] + b[i];
                    end
                end
                always @(sum[WIDTH-2] or sum[WIDTH-1]) begin
                    carry <= sum[WIDTH-1];
                end
            end
        else
            always @(a or b) begin
                {carry, sum} <= a + b;
            end
    endgenerate
endmodule