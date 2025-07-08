module bcd_to_gray #(
  parameter BCD_WIDTH = 4,
  parameter GRAY_WIDTH = 4
) (
  input [BCD_WIDTH-1:0] bcd,
  output [GRAY_WIDTH-1:0] gray
);
  wire [GRAY_WIDTH-1:0] temp;
  generate
    genvar i;
    for (i = 0; i < BCD_WIDTH; i++) begin : loop
      assign temp[i] = bcd[i] ^ bcd[i+1];
    end
  endgenerate
  assign gray = temp;
endmodule