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
        
        // Test case 1: Simple subtraction without borrowing
        a = 5; b = 3;
        #10;
        
        // Test case 2: Borrowing occurs
        a = 3; b = 5;
        #10;
        
        // Test case 3: Maximum value minus one
        a = (1 << WIDTH) - 1; b = 1;
        #10;
        
        // Test case 4: Zero minus zero
        a = 0; b = 0;
        #10;
        
        // Test case 5: All ones minus all ones
        a = (1 << WIDTH) - 1; b = (1 << WIDTH) - 1;
        #10;
        
        // Test case 6: Edge case with maximum width
        a = (1 << WIDTH) - 1; b = 0;
        #10;
        
        // Test case 7: Minimum value minus minimum value
        a = 0; b = 0;
        #10;
        
        // Test case 8: Random values
        a = $random; b = $random;
        #10;
        
        // End simulation
        $finish;
    end
    
    always @(posedge $finish) begin
        $display("Simulation finished.");
    end
    
    always @(posedge $time) begin
        $monitor("%t A=%d B=%d DIFF=%d BORROW=%b", $time, a, b, diff, borrow);
    end
endmodule