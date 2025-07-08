module tb_half_adder;
    reg a;
    reg b;
    wire sum;
    wire carry;

    half_adder uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // Initialize Inputs
        a = 0; b = 0;
        #10;
        a = 1; b = 0;
        #10;
        a = 0; b = 1;
        #10;
        a = 1; b = 1;
        #10;
        
        // Edge case: Toggle inputs rapidly
        for (int i=0; i<5; i=i+1) begin
            a = ~a;
            b = ~b;
            #2;
        end
        
        // Corner case: Hold at max value
        a = 1; b = 1;
        #20;
        
        // Final state
        a = 0; b = 0;
        #10;
        
        $finish;
    end
    
    always @(posedge a or posedge b) begin
        $display("a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    end
endmodule