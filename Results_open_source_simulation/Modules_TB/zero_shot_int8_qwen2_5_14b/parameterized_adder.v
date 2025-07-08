module tb_param_adder;
    parameter WIDTH = 8;
    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] sum;
    wire carry;

    param_adder #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0;
        #10;
        
        // Test case 1: Both inputs zero
        a = 0; b = 0;
        #10;
        
        // Test case 2: Maximum values without overflow
        a = (1 << (WIDTH-1)); b = (1 << (WIDTH-1));
        #10;
        
        // Test case 3: Maximum value for one input with another as zero
        a = (1 << WIDTH) - 1; b = 0;
        #10;
        
        // Test case 4: Maximum value for both inputs causing overflow
        a = (1 << WIDTH) - 1; b = (1 << WIDTH) - 1;
        #10;
        
        // Test case 5: Random values
        a = $random; b = $random;
        #10;
        
        // Test case 6: Edge case where carry should be generated
        a = (1 << (WIDTH-1)) - 1; b = 1;
        #10;
        
        // Test case 7: All ones in both inputs
        a = (1 << WIDTH) - 1; b = (1 << WIDTH) - 1;
        #10;
        
        // Finalize
        $stop;
    end
    
    always @(posedge $time) begin
        $display("Time %t | A=%d B=%d SUM=%d CARRY=%b", $time, a, b, sum, carry);
    end
endmodule