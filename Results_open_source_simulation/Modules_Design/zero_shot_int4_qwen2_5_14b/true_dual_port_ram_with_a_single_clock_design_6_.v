module true_dpram_sclk(
    input wire [7:0] data_a,
    input wire [7:0] data_b,
    input wire [5:0] addr_a,
    input wire [5:0] addr_b,
    input wire we_a,
    input wire we_b,
    input wire clk,
    output reg [7:0] q_a,
    output reg [7:0] q_b
);
    reg [7:0] mem [63:0];

    always @(posedge clk) begin
        if (we_a)
            mem[addr_a] <= data_a;
        if (we_b)
            mem[addr_b] <= data_b;
    end

    always @* begin
        q_a = mem[addr_a];
        q_b = mem[addr_b];
    end
endmodule