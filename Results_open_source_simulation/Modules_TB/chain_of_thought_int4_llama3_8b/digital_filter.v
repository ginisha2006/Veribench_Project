module digital_filter_tb;
parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

reg clk;
reg rst;
wire [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

initial begin
    #10; // delay for setup
    rst = 1'b1;
    repeat (5) @(posedge clk); // wait for 5 cycles
    rst = 1'b0;
    repeat (20) @(posedge clk); // wait for 20 cycles
    rst = 1'b1;
    repeat (5) @(posedge clk); // wait for 5 cycles
    rst = 1'b0;
    repeat (10) @(posedge clk); // wait for 10 cycles
    $monitor($time, "clk:", clk, "rst:", rst, "data_in:", data_in, "data_out:", data_out);
end

always #5 clk = ~clk; // clock generation

initial begin
    $display("Running...");
    #50; // delay for setup
    data_in <= 16'h0001; // initial data value
    coeff[0] <= 16'h0002; // initial coefficient value
    coeff[1] <= 16'h0003; // initial coefficient value
    coeff[2] <= 16'h0004; // initial coefficient value
    coeff[3] <= 16'h0005; // initial coefficient value
    coeff[4] <= 16'h0006; // initial coefficient value
    coeff[5] <= 16'h0007; // initial coefficient value
    coeff[6] <= 16'h0008; // initial coefficient value
    coeff[7] <= 16'h0009; // initial coefficient value
    coeff[8] <= 16'h000A; // initial coefficient value
    coeff[9] <= 16'h000B; // initial coefficient value
    coeff[10] <= 16'h000C; // initial coefficient value
    coeff[11] <= 16'h000D; // initial coefficient value
    coeff[12] <= 16'h000E; // initial coefficient value
    coeff[13] <= 16'h000F; // initial coefficient value
    coeff[14] <= 16'h0010; // initial coefficient value
    coeff[15] <= 16'h0011; // initial coefficient value
    coeff[16] <= 16'h0012; // initial coefficient value
    coeff[17] <= 16'h0013; // initial coefficient value
    coeff[18] <= 16'h0014; // initial coefficient value
    coeff[19] <= 16'h0015; // initial coefficient value
    coeff[20] <= 16'h0016; // initial coefficient value
    coeff[21] <= 16'h0017; // initial coefficient value
    coeff[22] <= 16'h0018; // initial coefficient value
    coeff[23] <= 16'h0019; // initial coefficient value
    coeff[24] <= 16'h001A; // initial coefficient value
    coeff[25] <= 16'h001B; // initial coefficient value
    coeff[26] <= 16'h001C; // initial coefficient value
    coeff[27] <= 16'h001D; // initial coefficient value
    coeff[28] <= 16'h001E; // initial coefficient value
    coeff[29] <= 16'h001F; // initial coefficient value
    coeff[30] <= 16'h0020; // initial coefficient value
    coeff[31] <= 16'h0021; // initial coefficient value
    #100; // delay for simulation
    $finish;
end

endmodule