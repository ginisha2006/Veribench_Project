module tb_digital_filter (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] data_out,
    input [15:0] coeff [31:0]
);

property posedge_clk;
 @(posedge clk) disable iff (!rst)
 endproperty

 assert property (posedge_clk);

 property reset_behavior;
 @(posedge rst) disable iff (!rst)
 data_out == 0;
 endproperty

 assert property (reset_behavior);

 property data_stability;
 @(posedge clk) disable iff (!rst)
 data_out !== data_out[posedge clk];
 endproperty

 assert property (data_stability);

 property coeff_boundaries;
 @(posedge clk) disable iff (!rst)
 foreach(coeff[i]) coeff[i] >= -2**15 && coeff[i] < 2**15;
 endproperty

 assert property (coeff_boundaries);

 property sum_of_coeffs;
 @(posedge clk) disable iff (!rst)
 ($sum($signed(coeff)) <= 2**16);
 endproperty

 assert property (sum_of_coeffs);

endmodule