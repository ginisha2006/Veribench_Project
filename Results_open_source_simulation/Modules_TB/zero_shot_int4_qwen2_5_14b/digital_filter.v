module tb_digital_filter;
    parameter DATA_WIDTH = 16;
    parameter COEFF_WIDTH = 16;
    parameter NUM_TAPS = 32;

    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    reg [COEFF_WIDTH-1:0] coeff[NUM_TAPS-1:0];

    digital_filter #(
        .DATA_WIDTH(DATA_WIDTH),
        .COEFF_WIDTH(COEFF_WIDTH),
        .NUM_TAPS(NUM_TAPS)
    ) dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out),
        .coeff(coeff)
    );

    initial begin
        clk <= 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst <= 1; @(posedge clk); rst <= 0;
        
        // Initialize coefficients
        for (int i=0; i<NUM_TAPS; i=i+1) 
            coeff[i] <= {COEFF_WIDTH{1'b0}};
            
        // Test case 1: All zeros input
        data_in <= 0;
        @(posedge clk);
        $monitor("Time %d: data_out=%b", $time, data_out);

        // Test case 2: Single non-zero value followed by zeros
        data_in <= 8'hAA;
        @(posedge clk);
        data_in <= 0;
        repeat(10) @(posedge clk);
        $monitor("Time %d: data_out=%b", $time, data_out);

        // Test case 3: Alternating values
        data_in <= 8'hAB;
        @(posedge clk);
        data_in <= 8'hCD;
        @(posedge clk);
        repeat(10) @(posedge clk);
        $monitor("Time %d: data_out=%b", $time, data_out);

        // Test case 4: Random sequence
        integer i;
        for(i=0;i<10;i++) begin
            data_in <= $random();
            @(posedge clk);
        end
        $monitor("Time %d: data_out=%b", $time, data_out);

        // Edge case: Maximum positive value
        data_in <= {DATA_WIDTH{1'b1}};
        @(posedge clk);
        $monitor("Time %d: data_out=%b", $time, data_out);

        // Edge case: Minimum negative value
        data_in <= {{DATA_WIDTH-1{1'b1}},1'b0};
        @(posedge clk);
        $monitor("Time %d: data_out=%b", $time, data_out);

        // Corner case: Coefficients set to maximum positive value
        for (i=0; i<NUM_TAPS; i=i+1) 
            coeff[i] <= {COEFF_WIDTH{1'b1}};
        @(posedge clk);
        $monitor("Time %d: data_out=%b", $time, data_out);

        // Corner case: Coefficients set to minimum negative value
        for (i=0; i<NUM_TAPS; i=i+1) 
            coeff[i] <= {{COEFF_WIDTH-1{1'b1}},1'b0};
        @(posedge clk);
        $monitor("Time %d: data_out=%b", $time, data_out);

        $finish;
    end
endmodule