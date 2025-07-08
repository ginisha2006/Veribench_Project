module param_multiplier #(parameter WIDTH=8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [2*WIDTH-1:0] product
);
    wire [WIDTH-1:0] a_shifted;
    wire [WIDTH-1:0] b_shifted;
    reg [2*WIDTH-1:0] partial_product;
    reg [2*WIDTH-1:0] running_sum;

    always @(posedge clock) begin
        if (a == 0 || b == 0)
            product <= 'b0;
        else begin
            partial_product <= a * b;
            running_sum <= running_sum + partial_product;
        end
    end

    assign product = running_sum;
endmodule