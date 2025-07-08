module seven_seg_display (
  input [DATA_WIDTH-1:0] data,
  output reg [6:0] seg
);

  parameter DATA_WIDTH = 4;

  always @(*) begin
    case (data)
      4'b0000: seg = 7'b1111110;
      4'b0001: seg = 7'b0110000;
      4'b0010: seg = 7'b1101101;
      4'b0011: seg = 7'b1111001;
      4'b0100: seg = 7'b0110011;
      4'b0101: seg = 7'b1011011;
      4'b0110: seg = 7'b1011111;
      4'b0111: seg = 7'b1110000;
      4'b1000: seg = 7'b1111111;
      4'b1001: seg = 7'b1110111;
      4'b1010: seg = 7'b1110011;
      4'b1011: seg = 7'b0111001;
      4'b1100: seg = 7'b0111111;
      4'b1101: seg = 7'b1011101;
      4'b1110: seg = 7'b1011001;
      4'b1111: seg = 7'b1110100;
      default: seg = 7'b0000000;
    endcase
  end

endmodule