module gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);

reg [7:0] bin_count;

always @(posedge clk) begin
    if (reset)
        bin_count <= 8'b0;
    else if (enable)
        bin_count <= bin_count + 1;
end

assign gray_count = {bin_count[7], ^bin_count[6:0], ^bin_count[5:1], ^bin_count[4:2], ^bin_count[3:1], ^bin_count[2:0], ^bin_count[1], ^bin_count[0]};
    
endmodule