module tb_seven_seg_display #(parameter DATA_WIDTH = 4);

  reg [DATA_WIDTH-1:0] data;
  wire [6:0] seg;

  seven_seg_display #(DATA_WIDTH) dut (
    .data(data),
    .seg(seg)
  );

  // Define properties for each digit
  always @(*) begin assert (data == 4'h0 && seg == 7'b1000000); end

  always @(*) begin assert (data == 4'h1 && seg == 7'b1111001); end

  // ... Add properties for digits 2 through F

  always @(*) begin assert (!((data == 4'h0) || (data == 4'h1) || ... || (data == 4'hF)) && seg != 7'b1111111); end

endmodule