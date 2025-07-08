module tb_full_adder;
    reg a;
    reg b;
    reg cin;
    wire sum;
    wire cout;

    full_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Initialize Inputs
        a = 0; b = 0; cin = 0;
        #10;
        a = 0; b = 0; cin = 1;
        #10;
        a = 0; b = 1; cin = 0;
        #10;
        a = 0; b = 1; cin = 1;
        #10;
        a = 1; b = 0; cin = 0;
        #10;
        a = 1; b = 0; cin = 1;
        #10;
        a = 1; b = 1; cin = 0;
        #10;
        a = 1; b = 1; cin = 1;
        #10;
        
        // Edge case: Toggle inputs rapidly
        a = 1'b1; b = 1'b0; cin = 1'b1;
        #5;
        a = 1'b0; b = 1'b1; cin = 1'b0;
        #5;
        a = 1'b1; b = 1'b1; cin = 1'b1;
        #5;
        a = 1'b0; b = 1'b0; cin = 1'b1;
        #5;
        
        // Finish
        $finish;
    end
    
    always @(posedge a or posedge b or posedge cin) begin
        $monitor($time, " a=%b b=%b cin=%b sum=%b cout=%b", a, b, cin, sum, cout);
    end
endmodule