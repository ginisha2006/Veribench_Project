module tb_bidir_pin;
    parameter WIDTH = 1;
    
    reg dir;
    reg [WIDTH-1:0] data_out;
    wire [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] pin;
    
    bidir_pin uut (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );
    
    initial begin
        $monitor($time, " ns: dir=%b, data_out=%b, data_in=%b", dir, data_out, data_in);
        
        // Initialize signals
        dir = 0; 
        data_out = 0;
        #10
        
        // Case 1: dir=0 (input mode), change data_in
        dir = 0;
        data_out = 0;
        pin = 1'b1;
        #10
        pin = 1'b0;
        #10
        
        // Case 2: dir=1 (output mode), change data_out
        dir = 1;
        data_out = 1'b1;
        #10
        data_out = 1'b0;
        #10
        
        // Edge case: Toggle direction rapidly
        dir = 0;
        data_out = 1'b1;
        #5
        dir = 1;
        #5
        dir = 0;
        #5
        dir = 1;
        #5
        
        // Corner case: High frequency toggling with different values
        for (int i = 0; i < 10; i++) begin
            if (i % 2 == 0) begin
                dir = 0;
                pin = ~pin;
            end else begin
                dir = 1;
                data_out = ~data_out;
            end
            #5
        end
        
        // Final state check
        dir = 0;
        data_out = 1'b1;
        pin = 1'b0;
        #10
        $finish;
    end
    
endmodule