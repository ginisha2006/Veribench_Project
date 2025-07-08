module param_counter #(parameter MAX_COUNT = 255)
    (
        input wire clk,
        input wire rst,
        output reg [7:0] count
    );
    always @(posedge clk) begin
        if (rst) count <= 8'h00;
        else if (count < MAX_COUNT) count <= count + 1'b1;
    end
endmodule