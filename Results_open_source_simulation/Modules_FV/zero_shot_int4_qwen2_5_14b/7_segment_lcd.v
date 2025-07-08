module tb_seven_seg_display();
    parameter DATA_WIDTH = 4;

    reg [DATA_WIDTH-1:0] data;
    wire [6:0] seg;

    seven_seg_display dut (
        .data(data),
        .seg(seg)
    );

    reg clk;
    always #5 clk = ~clk;

    property prop_data_to_seg_0;
        @(posedge clk) disable iff (!reset)
        data == 4'h0 |-> seg == 7'b1000000;
    endproperty
    assert property(prop_data_to_seg_0);

    property prop_data_to_seg_1;
        @(posedge clk) disable iff (!reset)
        data == 4'h1 |-> seg == 7'b1111001;
    endproperty
    assert property(prop_data_to_seg_1);

    property prop_data_to_seg_2;
        @(posedge clk) disable iff (!reset)
        data == 4'h2 |-> seg == 7'b0100100;
    endproperty
    assert property(prop_data_to_seg_2);

    property prop_data_to_seg_3;
        @(posedge clk) disable iff (!reset)
        data == 4'h3 |-> seg == 7'b0110000;
    endproperty
    assert property(prop_data_to_seg_3);

    property prop_data_to_seg_4;
        @(posedge clk) disable iff (!reset)
        data == 4'h4 |-> seg == 7'b0011001;
    endproperty
    assert property(prop_data_to_seg_4);

    property prop_data_to_seg_5;
        @(posedge clk) disable iff (!reset)
        data == 4'h5 |-> seg == 7'b0010010;
    endproperty
    assert property(prop_data_to_seg_5);

    property prop_data_to_seg_6;
        @(posedge clk) disable iff (!reset)
        data == 4'h6 |-> seg == 7'b0000010;
    endproperty
    assert property(prop_data_to_seg_6);

    property prop_data_to_seg_7;
        @(posedge clk) disable iff (!reset)
        data == 4'h7 |-> seg == 7'b1111000;
    endproperty
    assert property(prop_data_to_seg_7);

    property prop_data_to_seg_8;
        @(posedge clk) disable iff (!reset)
        data == 4'h8 |-> seg == 7'b0000000;
    endproperty
    assert property(prop_data_to_seg_8);

    property prop_data_to_seg_9;
        @(posedge clk) disable iff (!reset)
        data == 4'h9 |-> seg == 7'b0011000;
    endproperty
    assert property(prop_data_to_seg_9);

    property prop_data_to_seg_A;
        @(posedge clk) disable iff (!reset)
        data == 4'hA |-> seg == 7'b0001000;
    endproperty
    assert property(prop_data_to_seq_A);

    property prop_data_to_seg_B;
        @(posedge clk) disable iff (!reset)
        data == 4'hB |-> seg == 7'b0000011;
    endproperty
    assert property(prop_data_to_seg_B);

    property prop_data_to_seg_C;
        @(posedge clk) disable iff (!reset)
        data == 4'hC |-> seg == 7'b1000110;
    endproperty
    assert property(prop_data_to_seg_C);

    property prop_data_to_seg_D;
        @(posedge clk) disable iff (!reset)
        data == 4'hD |-> seg == 7'b0100001;
    endproperty
    assert property(prop_data_to_seg_D);

    property prop_data_to_seg_E;
        @(posedge clk) disable iff (!reset)
        data == 4'hE |-> seg == 7'b0000110;
    endproperty
    assert property(prop_data_to_seg_E);

    property prop_data_to_seg_F;
        @(posedge clk) disable iff (!reset)
        data == 4'hF |-> seg == 7'b0001110;
    endproperty
    assert property(prop_data_to_seg_F);

    property prop_default_case;
        @(posedge clk) disable iff (!reset)
        !(data inside {[4'h0 : 4'hF]}) |-> seg == 7'b1111111;
    endproperty
    assert property(prop_default_case);

endmodule