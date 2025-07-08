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
        coeff = '{default: 8'd1}; // Initialize all coefficients to 1
        
        #10 rst = 0;
        
        // Test with different inputs and coefficients
        data_in = 16'hFFFF;
        coeff[0] = 16'hFFFF;
        coeff[1] = 16'hFFFE;
        coeff[2] = 16'hFFF7;
        #20
        
        data_in = 16'h0000;
        coeff[0] = 16'h0001;
        coeff[1] = 16'h0002;
        coeff[2] = 16'h0004;
        #20
        
        data_in = 16'hAAAA;
        coeff[0] = 16'hBBBB;
        coeff[1] = 16'hCCCC;
        coeff[2] = 16'hDDDD;
        #20
        
        data_in = 16'h5555;
        coeff[0] = 16'hAABB;
        coeff[1] = 16'hCCDD;
        coeff[2] = 16'hEEFF;
        #20
        
        // Edge case - max value for data_in and coefficients
        data_in = 16'hFFFF;
        coeff[0] = 16'hFFFF;
        coeff[1] = 16'hFFFF;
        coeff[2] = 16'hFFFF;
        #20
        
        // Corner case - min value for data_in and coefficients
        data_in = 16'h0000;
        coeff[0] = 16'h0000;
        coeff[1] = 16'h0000;
        coeff[2] = 16'h0000;
        #20
        
        // Random values
        data_in = $random;
        coeff[0] = $random;
        coeff[1] = $random;
        coeff[2] = $random;
        #20
        
        $finish;
    end
    
    always @(posedge clk) begin
        if (rst)
            $monitor($time," ns | Reset asserted");
        else
            $monitor($time," ns | Data in: %h, Coefficients: %h %h %h, Data out: %h", data_in, coeff[0], coeff[1], coeff[2], data_out);
    end

    digital_filter #(.DATA_WIDTH(DATA_WIDTH), .COEFF_WIDTH(COEFF_WIDTH), .NUM_TAPS(NUM_TAPS)) dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out),
        .coeff(coeff)
    );
endmodule