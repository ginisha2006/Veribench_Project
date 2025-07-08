module gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
    always @(posedge clk) begin
        if (reset)
            gray_count <= 8'b0;
        else if (enable)
            gray_count <= {gray_count[6:0], ^gray_count};
    end
endmodule