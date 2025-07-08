module tb_full_adder;
    reg a, b, cin;
    wire sum, cout;

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
        #10 a = 1; b = 0; cin = 0;
        #10 a = 0; b = 1; cin = 0;
        #10 a = 1; b = 1; cin = 0;
        #10 a = 0; b = 0; cin = 1;
        #10 a = 1; b = 0; cin = 1;
        #10 a = 0; b = 1; cin = 1;
        #10 a = 1; b = 1; cin = 1;
        
        // Wait 100 ns for global signal to finish changing
        #100 $finish;
    end
    
    always @(posedge a or posedge b or posedge cin) begin
        $display("a=%b, b=%b, cin=%b, sum=%b, cout=%b", a, b, cin, sum, cout);
    end
endmodule