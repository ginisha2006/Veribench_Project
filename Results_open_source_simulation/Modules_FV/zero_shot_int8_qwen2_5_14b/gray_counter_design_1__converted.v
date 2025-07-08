module tb_gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
    wire clk_wire;
    assign clk_wire = clk;

    gray_count dut (
        .clk(clk_wire),
        .enable(enable),
        .reset(reset),
        .gray_count(gray_count)
    );

    // Clock generation
    reg clk_gen;
    always #5 clk_gen = ~clk_gen;
    assign clk = clk_gen;

    // Properties
    assert (@(posedge reset) disable iff (!reset)
            gray_count == 8'b0 && reset == 1);

    assert (@(posedge clk) disable iff (!enable || reset)
            gray_count != gray_count[posedge clk]);

    assert (@(posedge clk) disable iff (!enable || reset)
            gray_count[posedge clk] !== gray_count);

    assert (@(posedge clk) disable iff (!enable || reset)
            gray_count[posedge clk] inside {8'b00000001, 8'b00000011, 8'b00000111, 8'b00001111, 8'b00011111, 8'b00111111, 8'b01111111, 8'b11111111});

endmodule