module behav_counter (
    input clk,
    input [7:0] d,
    input load,
    input clear,
    output reg [7:0] cnt
);
    always @(posedge clk) begin
        if (load) begin
            cnt <= d;
        end else if (clear) begin
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
        end
    end
endmodule