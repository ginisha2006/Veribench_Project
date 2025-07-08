module gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
    always @(posedge clk) begin
        if (reset)
            gray_count <= 0;
        else if (enable)
            gray_count <= gray_count << 1 ^ gray_count;
    end
endmodule