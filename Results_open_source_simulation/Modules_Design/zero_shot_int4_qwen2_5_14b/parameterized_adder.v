module param_adder #(
    parameter WIDTH = 8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [WIDTH-1:0] sum,
    output reg carry
);
    genvar i;
    generate
        if(WIDTH > 1) begin : gen_dsp_adder
            for(i=0; i<WIDTH-1; i=i+1) begin
                assign {sum[i],carry} = a[i]+b[i]+carry;
            end
            assign {sum[WIDTH-1],carry} = a[WIDTH-1]+b[WIDTH-1]+carry;
        end else begin : gen_simple_adder
            assign {sum[0],carry} = a[0]+b[0];
        end
    endgenerate
endmodule