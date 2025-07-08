timescale 1ns/10ps

module digital_filter_tb;

parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

reg clk;
reg rst;
wire [DATA_WIDTH-1:0] data_in;
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
    #100; // Set up initial conditions
    rst = 1'b1;
    repeat (5) @(posedge clk); // Hold reset high for 5 clock cycles
    rst = 1'b0;
    
    // Test with valid coefficients
    coeff[0] = 16'd1234;
    coeff[1] = 16'd5678;
    coeff[2] = 16'd9012;
    coeff[3] = 16'd3456;
    coeff[4] = 16'd7890;
    coeff[5] = 16'd2345;
    coeff[6] = 16'd6789;
    coeff[7] = 16'd4567;
    coeff[8] = 16'd8901;
    coeff[9] = 16'd0123;
    coeff[10] = 16'd3456;
    coeff[11] = 16'd9012;
    coeff[12] = 16'd5678;
    coeff[13] = 16'd1234;
    coeff[14] = 16'd7890;
    coeff[15] = 16'd2345;
    coeff[16] = 16'd6789;
    coeff[17] = 16'd4567;
    coeff[18] = 16'd8901;
    coeff[19] = 16'd0123;
    coeff[20] = 16'd3456;
    coeff[21] = 16'd9012;
    coeff[22] = 16'd5678;
    coeff[23] = 16'd1234;
    coeff[24] = 16'd7890;
    coeff[25] = 16'd2345;
    coeff[26] = 16'd6789;
    coeff[27] = 16'd4567;
    coeff[28] = 16'd8901;
    coeff[29] = 16'd0123;
    coeff[30] = 16'd3456;
    coeff[31] = 16'd9012;
    
    // Apply random data
    repeat (100) begin
        $random seed (42);
        data_in = $random();
        @(posedge clk);
    end
    
    // Test with invalid coefficients
    coeff[0] = 16'd0;
    coeff[1] = 16'd0;
    coeff[2] = 16'd0;
    coeff[3] = 16'd0;
    coeff[4] = 16'd0;
    coeff[5] = 16'd0;
    coeff[6] = 16'd0;
    coeff[7] = 16'd0;
    coeff[8] = 16'd0;
    coeff[9] = 16'd0;
    coeff[10] = 16'd0;
    coeff[11] = 16'd0;
    coeff[12] = 16'd0;
    coeff[13] = 16'd0;
    coeff[14] = 16'd0;
    coeff[15] = 16'd0;
    coeff[16] = 16'd0;
    coeff[17] = 16'd0;
    coeff[18] = 16'd0;
    coeff[19] = 16'd0;
    coeff[20] = 16'd0;
    coeff[21] = 16'd0;
    coeff[22] = 16'd0;
    coeff[23] = 16'd0;
    coeff[24] = 16'd0;
    coeff[25] = 16'd0;
    coeff[26] = 16'd0;
    coeff[27] = 16'd0;
    coeff[28] = 16'd0;
    coeff[29] = 16'd0;
    coeff[30] = 16'd0;
    coeff[31] = 16'd0;
    
    // Apply random data
    repeat (100) begin
        $random seed (42);
        data_in = $random();
        @(posedge clk);
    end
    
    #100; // Wait for some time before stopping
    $finish;
end

always #5 clk = ~clk;