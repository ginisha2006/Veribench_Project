module tb_full_adder;
// Inputs
reg a;
reg b;
reg cin;
// Outputs
wire sum;
wire cout;
// Instantiate the Full Adder
full_adder uut (
    .a(a), 
    .b(b), 
    .cin(cin), 
    .sum(sum), 
    .cout(cout)
);
initial begin
    // Display the header for the output
    $display("Time	a	b	cin	sum	cout");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, a, b, cin, sum, cout);
    // Test all possible input combinations
    a = 0; b = 0; cin = 0; #10;
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 0; #10;
    a = 1; b = 1; cin = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule