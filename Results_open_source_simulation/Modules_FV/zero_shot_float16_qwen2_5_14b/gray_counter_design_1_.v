module tb_gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
    wire clk_wire;
    reg enable_reg;
    reg reset_reg;

    // DUT instantiation
    gray_count dut (
        .clk(clk_wire),
        .enable(enable_reg),
        .reset(reset_reg),
        .gray_count(gray_count)
    );

    // Clock generation
    always #5 clk_wire = ~clk_wire;

    // Properties for functional correctness
    property p_reset_behavior;
        @(posedge reset_reg) disable iff (!reset_reg)
            reset_reg ##1 gray_count == 8'b0 && gray_count[0] == 1;
    endproperty
    assert property(p_reset_behavior);

    property p_enable_behavior;
        @(posedge enable_reg && posedge clk_wire) disable iff (!enable_reg || !reset_reg)
            gray_count != gray_count[*1] |-> gray_count !== gray_count[*1];
    endproperty
    assert property(p_enable_behavior);

    // Properties for no ones below logic
    property p_no_ones_below;
        @(posedge clk_wire) disable iff (!reset_reg)
            gray_count[0] === 1 -> gray_count[1:0] inside {2'b00, 2'b01};
        @(posedge clk_wire) disable iff (!reset_reg)
            gray_count[1:0] inside {2'b00, 2'b01} -> gray_count[2:0] inside {3'b000, 3'b001, 3'b010};
        @(posedge clk_wire) disable iff (!reset_reg)
            gray_count[2:0] inside {3'b000, 3'b001, 3'b010} -> gray_count[3:0] inside {4'b0000, 4'b0001, 4'b0010, 4'b0100, 4'b0101, 4'b0110};
        @(posedge clk_wire) disable iff (!reset_reg)
            gray_count[3:0] inside {4'b0000, 4'b0001, 4'b0010, 4'b0100, 4'b0101, 4'b0110} -> gray_count[4:0] inside {5'b00000, 5'b00001, 5'b00010, 5'b00100, 5'b00101, 5'b00110, 5'b01000, 5'b01001, 5'b01010, 5'b01100, 5'b01101, 5'b01110};
        @(posedge clk_wire) disable iff (!reset_reg)
            gray_count[4:0] inside {5'b00000, 5'b00001, 5'b00010, 5'b00100, 5'b00101, 5'b00110, 5'b01000, 5'b01001, 5'b01010, 5'b01100, 5'b01101, 5'b01110} -> gray_count[5:0] inside {6'b000000, 6'b000001, 6'b000010, 6'b000100, 6'b000101, 6'b000110, 6'b001000, 6'b001001, 6'b001010, 6'b001100, 6'b001101, 6'b001110, 6'b010000, 6'b010001, 6'b010010, 6'b010100, 6'b010101, 6'b010110, 6'b011000, 6'b011001, 6'b011010, 6'b011100, 6'b011101, 6'b011110};
        @(posedge clk_wire) disable iff (!reset_reg)
            gray_count[