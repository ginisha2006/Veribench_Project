module true_dpram_sclk (
    input [7:0] data_a,
    input [7:0] data_b,
    input [5:0] addr_a,
    input [5:0] addr_b,
    input we_a,
    input we_b,
    input clk,
    output [7:0] q_a,
    output [7:0] q_b
);

    reg [7:0] mem [0:31];
    always @(posedge clk) begin
        if (we_a) begin
            mem[addr_a] <= data_a;
        end
        if (we_b) begin
            mem[addr_b] <= data_b;
        end
    end

    assign q_a = mem[addr_a];
    assign q_b = mem[addr_b];

endmodule