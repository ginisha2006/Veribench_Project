module tb_fft_module;
    parameter DATA_WIDTH = 16;
    parameter FFT_POINTS = 1024;

    reg clk;
    reg rst;
    reg start;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire done;

    fft_module #(.DATA_WIDTH(DATA_WIDTH), .FFT_POINTS(FFT_POINTS)) uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data_in(data_in),
        .data_out(data_out),
        .done(done)
    );

    initial begin
        clk <= 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst <= 1;
        start <= 0;
        data_in <= 0;
        #10;
        rst <= 0;
        #10;
        
        // Test case 1: Normal operation with valid data
        start <= 1;
        data_in <= 10'd1;
        #20;
        start <= 0;
        #100;
        
        // Test case 2: Start while processing
        start <= 1;
        #20;
        start <= 0;
        #100;
        
        // Test case 3: Reset during processing
        start <= 1;
        #10;
        rst <= 1;
        #10;
        rst <= 0;
        #100;
        
        // Test case 4: Edge case - max value in data_in
        start <= 1;
        data_in <= {DATA_WIDTH{1'b1}};
        #20;
        start <= 0;
        #100;
        
        // Test case 5: Zero value in data_in
        start <= 1;
        data_in <= 0;
        #20;
        start <= 0;
        #100;
        
        $finish;
    end
    
    always @(posedge clk) if (!rst && done) $display("Data out: %d", data_out);

endmodule