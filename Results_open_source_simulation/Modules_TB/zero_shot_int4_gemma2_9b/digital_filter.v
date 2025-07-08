module digital_filter_tb #(
    parameter DATA_WIDTH = 16,
    parameter COEFF_WIDTH = 16,
    parameter NUM_TAPS = 32
);

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

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    
    // Stimulus generation here
  end

  always @(posedge clk) begin
    $monitor("Time: %t clk=%b rst=%b data_in=%h data_out=%h", $time, clk, rst, data_in, data_out);
  end

endmodule