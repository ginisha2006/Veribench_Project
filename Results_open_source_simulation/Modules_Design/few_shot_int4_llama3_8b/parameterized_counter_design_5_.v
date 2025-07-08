module param_counter #(parameter MAX_COUNT = 255) (
    input clk,
    input rst,
    output reg [7:0] count
);
    always @(posedge clk) begin
        if (rst) count <= 0;
        else if (count == MAX_COUNT - 1) count <= 0;
        else count <= count + 1;
    end
endmodule