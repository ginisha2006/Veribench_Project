module param_counter #(
    parameter integer MAX_COUNT = 255
)(
    input wire clk,
    input wire rst,
    output reg [7:0] count
);

reg [7:0] next_count;

always @(posedge clk or posedge rst)
begin
    if (rst)
        count <= 8'b0;
    else
        count <= next_count;
end

always @*
begin
    if (count == MAX_COUNT)
        next_count = 8'b0;
    else
        next_count = count + 1;
end

endmodule