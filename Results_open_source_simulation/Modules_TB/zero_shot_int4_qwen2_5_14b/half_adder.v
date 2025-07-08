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
        
        // Edge case: Toggle inputs rapidly
        a = 0; b = 0;
        #5;
        a = 1; b = 0;
        #2;
        a = 0; b = 1;
        #3;
        a = 1; b = 1;
        #4;
        a = 0; b = 0;
        #6;
        
        // Corner case: Long hold time on inputs
        a = 1; b = 1;
        #100;
        a = 0; b = 0;
        #100;
        
        // End of test
        $finish;
    end
    
    always @(posedge a or posedge b) begin
        $monitor($time, " ns: a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    end
endmodule