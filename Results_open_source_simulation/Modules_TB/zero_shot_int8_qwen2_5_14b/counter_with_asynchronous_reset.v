module tb_counter;
    reg clk;
    reg reset;
    reg ena;
    wire [7:0] result;
    
    counter uut (
        .clk(clk),
        .reset(reset),
        .result(result),
        .ena(ena)
    );
    
    initial begin
        // Initialize inputs
        clk <= 0;
        reset <= 0;
        ena <= 0;
        
        #10 reset <= 1; // Apply reset for 10 time units
        #10 reset <= 0;
        
        #10 ena <= 1; // Enable counting
        
        // Clock generation
        forever begin
            #5 clk <= ~clk;
        end
    end
    
    always @(posedge clk) begin
        if (ena && !reset) 
            $display("Time %d: Result = %b", $time, result);
    end
    
    initial begin
        #100 $finish;
    end
endmodule