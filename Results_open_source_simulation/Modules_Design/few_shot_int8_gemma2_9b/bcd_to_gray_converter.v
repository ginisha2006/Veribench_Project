module bcd_to_gray #(
  parameter BCD_WIDTH = 4,
  parameter GRAY_WIDTH = 4
) (
  input [BCD_WIDTH-1:0] bcd,
  output [GRAY_WIDTH-1:0] gray
);
  wire [GRAY_WIDTH-1:0] temp;
  genvar i;
  generate
    for (i = 0; i < BCD_WIDTH; i = i + 1) begin : loop
      full_adder fa (
        .a(bcd[i]),
        .b(bcd[i]),
        .cin(i > 0 ? temp[i-1] : 1'b0),
        .sum(temp[2*i]),
        .cout(temp[2*i+1])
      );
    end
  endgenerate
  assign gray = temp;
endmodule