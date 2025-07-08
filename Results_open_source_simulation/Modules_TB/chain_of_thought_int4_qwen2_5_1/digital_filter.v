module tb_digital_filter;
parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

reg clk;
reg rst;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;
reg [COEFF_WIDTH-1:0] coeff[NUM_TAPS-1:0];

digital_filter #(.DATA_WIDTH(DATA_WIDTH), .COEFF_WIDTH(COEFF_WIDTH), .NUM_TAPS(NUM_TAPS)) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
);

initial begin
    clk <= 0; 
    rst <= 1; 
    @(posedge clk) rst <= 0;
    @(posedge clk) data_in <= 8'd5;
    @(posedge clk) coeff[0] <= 8'd1;
    @(posedge clk) coeff[1] <= 8'd2;
    @(posedge clk) coeff[2] <= 8'd3;
    repeat(10) @(posedge clk);
    @(posedge clk) data_in <= 8'hff;
    @(posedge clk) coeff[0] <= 8'hff;
    @(posedge clk) coeff[1] <= 8'hfe;
    @(posedge clk) coeff[2] <= 8'hd7;
    repeat(10) @(posedge clk);
    @(posedge clk) data_in <= 8'd0;
    @(posedge clk) coeff[0] <= 8'd0;
    @(posedge clk) coeff[1] <= 8'd0;
    @(posedge clk) coeff[2] <= 8'd0;
    repeat(10) @(posedge clk);
    $finish;
end

always #5 clk = ~clk;

initial begin
    $dumpfile("tb_digital_filter.vcd");
    $dumpvars(0,tb_digital_filter);
end

initial begin
    $monitor($time," ns: data_out=%h", data_out);
end
endmodule