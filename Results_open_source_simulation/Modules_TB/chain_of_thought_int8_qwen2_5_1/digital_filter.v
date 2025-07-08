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
        coeff <= '{default: 8'd1}; // Initialize coefficients with default value
        
        #10 rst = 0;
        
        // Test case 1: Normal operation
        data_in = 16'hFFFF;
        #20;
        data_in = 16'h0000;
        #20;
        data_in = 16'hAAAA;
        #20;
        
        // Test case 2: Edge case - max input
        data_in = 16'hFFFF;
        #20;
        
        // Test case 3: Edge case - min input
        data_in = 16'h0000;
        #20;
        
        // Test case 4: Random inputs
        repeat(10) begin
            data_in = $random();
            #20;
        end
        
        $stop;
    end

    initial begin
        $dumpfile("tb_digital_filter.vcd");
        $dumpvars(0, tb_digital_filter);
    end
    
    always @(posedge clk)
        if (!rst)
            $monitor($time," ns | Data Out = %h", data_out);

    digital_filter #(.DATA_WIDTH(DATA_WIDTH), .COEFF_WIDTH(COEFF_WIDTH), .NUM_TAPS(NUM_TAPS)) dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out),
        .coeff(coeff)
    );
endmodule