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
        
        // Test case 1: Normal subtraction with positive numbers
        a = 5; b = 3;
        #10;
        
        // Test case 2: Borrow case (negative result)
        a = 3; b = 5;
        #10;
        
        // Test case 3: Maximum value minus one less than maximum
        a = 255; b = 254;
        #10;
        
        // Test case 4: Zero minus zero
        a = 0; b = 0;
        #10;
        
        // Test case 5: All ones minus all zeros
        a = '1; b = '0;
        #10;
        
        // Test case 6: All zeros minus all ones
        a = '0; b = '1;
        #10;
        
        // Test case 7: Half range values
        a = WIDTH/2; b = WIDTH/2 + 1;
        #10;
        
        // Finalize
        $finish;
    end
    
    always @(posedge $anyseq(a) or posedge $anyseq(b)) begin
        $display("a=%d, b=%d, diff=%d, borrow=%b", a, b, diff, borrow);
    end
endmodule