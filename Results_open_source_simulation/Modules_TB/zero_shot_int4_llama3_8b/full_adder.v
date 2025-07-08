module full_adder_tb;

parameter PERIOD = 10;

reg clk;
reg rst;
wire [1:0] a;
wire [1:0] b;
wire cin;
wire sum;
wire cout;

full_adder uut (
   .a(a[0]),
   .b(b[0]),
   .cin(cin),
   .sum(sum),
   .cout(cout)
);

initial begin
    #PERIOD; // wait for clock cycle
    rst = 1'b1; // reset
    #PERIOD; rst = 1'b0; // release reset

    // Test case 1: all inputs low
    a <= 2'b00;
    b <= 2'b00;
    cin <= 1'b0;
    #PERIOD;
    $display("Test case 1: all inputs low");
    $display("Sum: %b", sum);
    $display("Cout: %b", cout);

    // Test case 2: all inputs high
    a <= 2'b11;
    b <= 2'b11;
    cin <= 1'b1;
    #PERIOD;
    $display("Test case 2: all inputs high");
    $display("Sum: %b", sum);
    $display("Cout: %b", cout);

    // Test case 3: one input low, one input high
    a <= 2'b01;
    b <= 2'b10;
    cin <= 1'b0;
    #PERIOD;
    $display("Test case 3: one input low, one input high");
    $display("Sum: %b", sum);
    $display("Cout: %b", cout);

    // Test case 4: carry-in set, both inputs low
    a <= 2'b00;
    b <= 2'b00;
    cin <= 1'b1;
    #PERIOD;
    $display("Test case 4: carry-in set, both inputs low");
    $display("Sum: %b", sum);
    $display("Cout: %b", cout);

    // Test case 5: carry-in set, both inputs high
    a <= 2'b11;
    b <= 2'b11;
    cin <= 1'b1;
    #PERIOD;
    $display("Test case 5: carry-in set, both inputs high");
    $display("Sum: %b", sum);
    $display("Cout: %b", cout);

    // Test case 6: carry-in clear, both inputs low
    a <= 2'b00;
    b <= 2'b00;
    cin <= 1'b0;
    #PERIOD;
    $display("Test case 6: carry-in clear, both inputs low");
    $display("Sum: %b", sum);
    $display("Cout: %b", cout);

    // Test case 7: carry-in clear, both inputs high
    a <= 2'b11;
    b <= 2'b11;
    cin <= 1'b0;
    #PERIOD;
    $display("Test case 7: carry-in clear, both inputs high");
    $display("Sum: %b", sum);
    $display("Cout: %b", cout);

    // Test case 8: carry-in toggle
    a <= 2'b01;
    b <= 2'b10;
    cin <= 1'b0;
    #PERIOD;
    cin <= 1'b1;
    #PERIOD;
    $display("Test case 8: carry-in toggle");
    $display("Sum: %b", sum);
    $display("Cout: %b", cout);

    #1000; // wait for some time before stopping simulation
    $finish;
end

always #PERIOD clk = ~clk; // clock generation

endmodule