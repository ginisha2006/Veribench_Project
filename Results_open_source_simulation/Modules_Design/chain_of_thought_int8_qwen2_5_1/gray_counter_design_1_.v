module gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);

reg [7:0] binary_count;

always @(posedge clk) begin
    if (reset)
        binary_count <= 8'b0;
    else if (enable)
        binary_count <= binary_count + 1;
end

assign gray_count = {binary_count[7], ^(binary_count[7:1]), binary_count[0]};

endmodule