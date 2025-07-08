module param_shift_reg #(
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input load,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk) begin
        if(rst)
            data_out <= 0;
        else if(load)
            data_out <= data_in;
        else
            data_out <= {data_out[WIDTH-2:0], data_out[WIDTH-1]};
    end
endmodule