module param_multiplier #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [2*WIDTH-1:0] product
);
    integer i;
    generate
        genvar j;
        for(j = 0; j < WIDTH; j = j + 1) begin : shift_reg_gen
            if(j == 0)
                wire [WIDTH-1:0] shifted_b = b;
            else
                wire [WIDTH-1:0] shifted_b = {b[j-1:0], WIDTH-j'b0};
            
            always @(posedge a[WIDTH-1]) begin
                product[(j+1)*WIDTH-1:j*WIDTH] <= a * shifted_b;
            end
        end
    endgenerate
    
    initial begin
        product = 0;
    end
endmodule