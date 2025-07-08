module seven_seg_display(data, seg);

  parameter DATA_WIDTH = 4;

  input [DATA_WIDTH-1:0] data;
  output [6:0] seg;

  wire [6:0] segment_out;

  assign seg = segment_out;

  always @(*) begin
    case (data)
      4'b0000: segment_out = 7'b1111110;
      4'b0001: segment_out = 7'b0110000;
      4'b0010: segment_out = 7'b1101101;
      4'b0011: segment_out = 7'b1111001;
      4'b0100: segment_out = 7'b0110011;
      4'b0101: segment_out = 7'b1011011;
      4'b0110: segment_out = 7'b1011111;
      4'b0111: segment_out = 7'b1110000;
      4'b1000: segment_out = 7'b0111101;
      4'b1001: segment_out = 7'b0110000;
      4'b1010: segment_out = 7'b0111111;
      4'b1011: segment_out = 7'b1110111;
      4'b1100: segment_out = 7'b1111101;
      4'b1101: segment_out = 7'b1111011;
      4'b1110: segment_out = 7'b1111111;
      4'b1111: segment_out = 7'b1111111;
      default: segment_out = 7'b0000000;
    endcase
  end

endmodule