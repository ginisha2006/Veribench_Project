module param_multiplier #(
    parameter WIDTH=8
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output reg [2*WIDTH-1:0] product
);

    (* use_dsp48=true *) // Enable DSP usage
    always @(*) begin
        product = a * b;
    end

endmodule