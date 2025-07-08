module tb_half_adder;
    reg a, b;
    wire sum, carry;

    half_adder uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        #10 a = 0; b = 0; 
        #10 a = 1; b = 0; 
        #10 a = 0; b = 1; 
        #10 a = 1; b = 1; 

        // Edge case: Toggle inputs rapidly
        #10 a = ~a; b = ~b; 
        #5 a = ~a; b = ~b; 
        #5 a = ~a; b = ~b; 
        #5 a = ~a; b = ~b; 
        
        // Corner case: Hold at max values for long time
        #20 a = 1; b = 1; 
        #40 a = 0; b = 0; 

        $finish;
    end

    always @(posedge a or posedge b) begin
        $display("a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    end
endmodule