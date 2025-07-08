module tb_param_subtractor;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] diff;
    wire borrow;

    param_subtractor #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .diff(diff),
        .borrow(borrow)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0;
        #10;
        
        // Test case 1: Normal subtraction (positive result)
        a = 5; b = 3;
        #10;
        
        // Test case 2: Borrow case (negative result)
        a = 3; b = 5;
        #10;
        
        // Test case 3: Maximum value subtraction
        a = 'd255; b = 'd255;
        #10;
        
        // Test case 4: Minimum value subtraction
        a = 'd0; b = 'd0;
        #10;
        
        // Test case 5: Edge case with maximum borrow
        a = 'd1; b = 'd256;
        #10;
        
        // Test case 6: Random values
        a = $random; b = $random;
        #10;
        
        // End simulation
        $finish;
    end
    
    always @(posedge $finish) begin
        $display("Simulation finished.");
    end
    
    initial begin
        $dumpfile("param_subtractor.vcd");
        $dumpvars(0, tb_param_subtractor);
    end
    
    always @(posedge $time) begin
        $monitor("%t A=%b B=%b DIFF=%b BORROW=%b", $time, a, b, diff, borrow);
    end
endmodule