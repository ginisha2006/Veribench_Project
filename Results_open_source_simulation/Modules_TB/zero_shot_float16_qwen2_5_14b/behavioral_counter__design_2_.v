module tb_behav_counter;
    reg [7:0] d;
    reg clk;
    reg clear;
    reg load;
    reg up_down;
    wire [7:0] qd;
    
    behav_counter uut (
        .d(d),
        .clk(clk),
        .clear(clear),
        .load(load),
        .up_down(up_down),
        .qd(qd)
    );
    
    initial begin
        // Initialize Inputs
        d = 8'b0000_0000;
        clk = 0;
        clear = 0;
        load = 0;
        up_down = 0;
        
        #10; // Initial delay
        
        // Test Case 1: Clear Signal
        clear = 1;
        #10;
        clear = 0;
        #10;
        
        // Test Case 2: Load Signal with Data
        load = 1;
        d = 8'b1010_1010;
        #10;
        load = 0;
        #10;
        
        // Test Case 3: Up Counting
        up_down = 1;
        for (int i=0; i<5; i=i+1) begin
            #10;
        end
        
        // Test Case 4: Down Counting
        up_down = 0;
        for (int i=0; i<5; i=i+1) begin
            #10;
        end
        
        // Edge Cases
        // Test Case 5: Toggle between Up and Down while loading data
        load = 1;
        d = 8'b1111_1111;
        #10;
        load = 0;
        up_down = 1;
        for (int i=0; i<3; i=i+1) begin
            #10;
        end
        up_down = 0;
        for (int i=0; i<3; i=i+1) begin
            #10;
        end
        
        // Final State Check
        $finish;
    end
    
    always #5 clk = ~clk;
    
    initial begin
        $monitor($time, " ns: clk=%b, clear=%b, load=%b, up_down=%b, d=%b, qd=%b", clk, clear, load, up_down, d, qd);
    end
endmodule