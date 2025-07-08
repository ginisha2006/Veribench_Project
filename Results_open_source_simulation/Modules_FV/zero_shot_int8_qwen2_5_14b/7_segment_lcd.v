module tb_seven_seg_display();
    parameter DATA_WIDTH = 4;
    
    logic [DATA_WIDTH-1:0] data;
    logic [6:0] seg;

    seven_seg_display dut (
        .data(data),
        .seg(seg)
    );

    // Clock generation
    logic clk;
    always #(5ns) clk = ~clk;

    // Functional correctness assertions
    property p_data_0; @(posedge clk) data == 4'h0 |-> seg == 7'b1000000; endproperty
    assert property(p_data_0);

    property p_data_1; @(posedge clk) data == 4'h1 |-> seg == 7'b1111001; endproperty
    assert property(p_data_1);

    property p_data_2; @(posedge clk) data == 4'h2 |-> seg == 7'b0100100; endproperty
    assert property(p_data_2);

    property p_data_3; @(posedge clk) data == 4'h3 |-> seg == 7'b0110000; endproperty
    assert property(p_data_3);

    property p_data_4; @(posedge clk) data == 4'h4 |-> seg == 7'b0011001; endproperty
    assert property(p_data_4);

    property p_data_5; @(posedge clk) data == 4'h5 |-> seg == 7'b0010010; endproperty
    assert property(p_data_5);

    property p_data_6; @(posedge clk) data == 4'h6 |-> seg == 7'b0000010; endproperty
    assert property(p_data_6);

    property p_data_7; @(posedge clk) data == 4'h7 |-> seg == 7'b1111000; endproperty
    assert property(p_data_7);

    property p_data_8; @(posedge clk) data == 4'h8 |-> seg == 7'b0000000; endproperty
    assert property(p_data_8);

    property p_data_9; @(posedge clk) data == 4'h9 |-> seg == 7'b0011000; endproperty
    assert property(p_data_9);

    property p_data_A; @(posedge clk) data == 4'hA |-> seg == 7'b0001000; endproperty
    assert property(p_data_A);

    property p_data_B; @(posedge clk) data == 4'hB |-> seg == 7'b0000011; endproperty
    assert property(p_data_B);

    property p_data_C; @(posedge clk) data == 4'hC |-> seg == 7'b1000110; endproperty
    assert property(p_data_C);

    property p_data_D; @(posedge clk) data == 4'hD |-> seg == 7'b0100001; endproperty
    assert property(p_data_D);

    property p_data_E; @(posedge clk) data == 4'hE |-> seg == 7'b0000110; endproperty
    assert property(p_data_E);

    property p_data_F; @(posedge clk) data == 4'hF |-> seg == 7'b0001110; endproperty
    assert property(p_data_F);

    property p_default; @(posedge clk) data != 4'h0 && data != 4'h1 && data != 4'h2 && data != 4'h3 && data != 4'h4 && data != 4'h5 && data != 4'h6 && data != 4'h7 && data != 4'h8 && data != 4'h9 && data != 4'hA && data != 4'hB && data != 4'hC && data != 4'hD && data != 4'hE && data != 4'hF |-> seg == 7'b1111111; endproperty
    assert property(p_default);

endmodule