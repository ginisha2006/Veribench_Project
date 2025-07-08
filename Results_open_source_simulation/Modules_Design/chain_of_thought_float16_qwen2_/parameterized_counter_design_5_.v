module param_counter #(
    parameter integer MAX_COUNT = 255
)(
    input wire clk,
    input wire rst,
    output reg [7:0] count
);

reg [8:0] internal_count;

always @(posedge clk or posedge rst)
begin
    if (rst)
        internal_count <= 9'b0;
    else
        internal_count <= internal_count + 1;
end

assign count = internal_count[7:0];

always @(posedge clk)
begin
    if (internal_count == MAX_COUNT)
        internal_count <= 9'b0;
end

endmodule