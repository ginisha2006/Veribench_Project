module tb_seven_seg_display (
    input [3:0] data,
    output reg [6:0] seg
);

seven_seg_display dut (
    .data(data),
    .seg(seg)
);

reg clk;
always #5 clk = ~clk;

property p_data_valid;
 @(posedge clk) disable iff (!reset)
    data inside {[4'h0 : 4'hF]};
endproperty
assert property(p_data_valid);

property p_default_case;
 @(posedge clk) disable iff (!reset)
    !($onehot0({data == 4'h0, data == 4'h1, ..., data == 4'hF})) |-> seg == 7'b1111111;
endproperty
assert property(p_default_case);

property p_segment_correctness;
 @(posedge clk) disable iff (!reset)
    case (data)
        4'h0: seg == 7'b1000000;
        4'h1: seg == 7'b1111001;
        4'h2: seg == 7'b0100100;
        4'h3: seg == 7'b0110000;
        4'h4: seg == 7'b0011001;
        4'h5: seg == 7'b0010010;
        4'h6: seg == 7'b0000010;
        4'h7: seg == 7'b1111000;
        4'h8: seg == 7'b0000000;
        4'h9: seg == 7'b0011000;
        4'hA: seg == 7'b0001000;
        4'hB: seg == 7'b0000011;
        4'hC: seg == 7'b1000110;
        4'hD: seg == 7'b0100001;
        4'hE: seg == 7'b0000110;
        4'hF: seg == 7'b0001110;
    endcase;
endproperty
assert property(p_segment_correctness);

endmodule