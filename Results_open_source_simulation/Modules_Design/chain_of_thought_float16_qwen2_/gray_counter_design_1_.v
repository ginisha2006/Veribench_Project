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

assign gray_count = {binary_count[7], ^(binary_count[7:1]) ^ binary_count[0],
                     ^(binary_count[6:0]) ^ binary_count[1],
                     ^(binary_count[5:0]) ^ binary_count[2],
                     ^(binary_count[4:0]) ^ binary_count[3],
                     ^(binary_count[3:0]) ^ binary_count[4],
                     ^(binary_count[2:0]) ^ binary_count[5],
                     ^(binary_count[1:0]) ^ binary_count[6]};
    
endmodule