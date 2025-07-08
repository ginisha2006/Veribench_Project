module tb_digital_filter;
    parameter DATA_WIDTH = 16;
    parameter COEFF_WIDTH = 16;
    parameter NUM_TAPS = 32;

    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    reg [COEFF_WIDTH-1:0] coeff[NUM_TAPS-1:0];

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst = 1;
        data_in = 0;
        for (int i=0; i<NUM_TAPS; i=i+1) coeff[i] = 0;
        #10 rst = 0;
        
        // Normal operation with typical values
        data_in = 8'd10;
        coeff[0] = 8'd1;
        coeff[1] = 8'd2;
        coeff[2] = 8'd3;
        #20
        
        // Edge case - max value input
        data_in = {DATA_WIDTH{1'b1}};
        coeff[0] = {COEFF_WIDTH{1'b1}};
        coeff[1] = {COEFF_WIDTH{1'b1}};
        coeff[2] = {COEFF_WIDTH{1'b1}};
        #20
        
        // Corner case - min value input
        data_in = {DATA_WIDTH{1'b0}};
        coeff[0] = {COEFF_WIDTH{1'b0}};
        coeff[1] = {COEFF_WIDTH{1'b0}};
        coeff[2] = {COEFF_WIDTH{1'b0}};
        #20
        
        // Mixed values
        data_in = 8'd7;
        coeff[0] = 8'd5;
        coeff[1] = 8'd3;
        coeff[2] = 8'd1;
        #20
        
        // Random values
        data_in = $random;
        coeff[0] = $random;
        coeff[1] = $random;
        coeff[2] = $random;
        #20
        
        $stop;
    end
    
    initial begin
        $dumpfile("tb_digital_filter.vcd");
        $dumpvars(0, tb_digital_filter);
    end

    digital_filter #(.DATA_WIDTH(DATA_WIDTH), .COEFF_WIDTH(COEFF_WIDTH), .NUM_TAPS(NUM_TAPS)) dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out),
        .coeff(coeff)
    );

    always @(posedge clk) begin
        $monitor("%t: data_out=%b", $time, data_out);
    end
endmodule