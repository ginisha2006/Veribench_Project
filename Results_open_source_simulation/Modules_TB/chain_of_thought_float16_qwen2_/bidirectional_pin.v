module tb_bidir_pin;
    reg [20:0] clk;
    reg dir;
    reg [20:0] data_out;
    wire [20:0] data_in;
    wire [20:0] pin;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    bidir_pin #(.WIDTH(21)) uut (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );

    initial begin
        // Initialize signals
        dir = 0;
        data_out = 21'b0;
        
        // Wait for some cycles before applying stimuli
        repeat (10) @ (posedge clk);
        
        // Case 1: dir is low, pin should be high-Z
        dir = 0;
        data_out = 21'hDEADBEEF;
        repeat (10) @ (posedge clk);
        
        // Case 2: dir is high, pin should follow data_out
        dir = 1;
        data_out = 21'hCAFEBABE;
        repeat (10) @ (posedge clk);
        
        // Edge case: Change direction during operation
        dir = 0;
        data_out = 21'hBADDCAFE;
        repeat (10) @ (posedge clk);
        
        // Corner case: All ones in data_out when dir is high
        dir = 1;
        data_out = 21'hFFFF_FFFF_FFF;
        repeat (10) @ (posedge clk);
        
        // Corner case: All zeros in data_out when dir is high
        dir = 1;
        data_out = 21'h0;
        repeat (10) @ (posedge clk);
        
        // Final check with random values
        dir = 1;
        data_out = $random;
        repeat (10) @ (posedge clk);
        
        // End simulation
        $finish;
    end
    
    always @(posedge clk) begin
        $monitor("Time %0t: dir=%b, data_out=0x%h, data_in=0x%h", $time, dir, data_out, data_in);
    end
endmodule