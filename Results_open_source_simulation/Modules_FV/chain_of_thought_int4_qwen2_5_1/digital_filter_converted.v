module tb_digital_filter (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] data_out,
    input [15:0] coeff [31:0]
);

always @(*) begin assert (@(posedge clk) disable iff (!rst)); end

 assert (@(posedge rst) disable iff (!rst)
 data_out == 0);

 assert (@(posedge clk) disable iff (!rst)
 data_out !== data_out[posedge clk]);

 assert (@(posedge clk) disable iff (!rst)
 foreach(coeff[i]) coeff[i] >= -2**15 && coeff[i] < 2**15);

 assert (@(posedge clk) disable iff (!rst)
 ($sum($signed(coeff)) <= 2**16));

endmodule