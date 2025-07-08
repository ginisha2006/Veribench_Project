module param_counter #(
    parameter integer MAX_COUNT = 255
)(
    input wire clk,
    input wire rst,
    output reg [7:0] count
);
    always @(posedge clk or posedge rst)
        if(rst)
            count <= 8'b0;
        else if(count == MAX_COUNT)
            count <= 8'b0;
        else
            count <= count + 1;
endmodule