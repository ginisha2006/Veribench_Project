module tb_bidir_pin;
    parameter WIDTH = 1;
    
    reg dir;
    reg [WIDTH-1:0] data_out;
    wire [WIDTH-1:0] data_in;
    inout [WIDTH-1:0] pin;
    
    bidir_pin uut (
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in),
        .pin(pin)
    );
    
    initial begin
        $monitor($time, " ns: dir=%b, data_out=%b, data_in=%b", dir, data_out, data_in);
        
        // Initial state
        dir <= 0; 
        data_out <= 0;
        repeat(5) @(posedge $clock);
        
        // Test case 1: dir=0 (input mode), change pin value
        dir <= 0;
        data_out <= 0;
        pin <= 1'b1;
        repeat(5) @(posedge $clock);
        
        // Test case 2: dir=1 (output mode), change data_out value
        dir <= 1;
        data_out <= 1;
        repeat(5) @(posedge $clock);
        
        // Test case 3: switch from output to input mode
        dir <= 0;
        data_out <= 1;
        pin <= 1'b0;
        repeat(5) @(posedge $clock);
        
        // Test case 4: switch from input to output mode
        dir <= 1;
        data_out <= 0;
        repeat(5) @(posedge $clock);
        
        // Final state
        dir <= 0;
        data_out <= 0;
        pin <= 1'b1;
        repeat(5) @(posedge $clock);
        
        $finish;
    end
    
    always #10 $clock = ~$clock;
    
    initial begin
        $dumpfile("tb_bidir_pin.vcd");
        $dumpvars(0, tb_bidir_pin);
        $clock = 0;
    end
endmodule