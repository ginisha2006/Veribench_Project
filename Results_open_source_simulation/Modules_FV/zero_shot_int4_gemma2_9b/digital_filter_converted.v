module tb_digital_filter;

  parameter DATA_WIDTH = 16;
  parameter COEFF_WIDTH = 16;
  parameter NUM_TAPS = 32;

  reg clk;
  reg rst;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

  digital_filter dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
  );

  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) coeff[0] != 0); end
  always @(*) begin assert (@(posedge clk) data_in >= 0 && data_in < 2**DATA_WIDTH); end

endmodule