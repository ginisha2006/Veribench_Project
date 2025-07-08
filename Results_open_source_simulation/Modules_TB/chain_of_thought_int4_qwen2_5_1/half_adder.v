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
        a = 0; b = 1;
        #10;
        a = 1; b = 0;
        #10;
        a = 1; b = 1;
        #10;
        
        // Edge case - rapid toggling
        for (int i=0; i<4; i++) begin
            a = ~a;
            b = ~b;
            #5;
        end
        
        // Final state
        a = 0; b = 0;
        #10;
        $finish;
    end
    
    always @(posedge a or posedge b) begin
        $monitor($time, " a=%b b=%b sum=%b carry=%b", a, b, sum, carry);
    end
endmodule