module param_comparator_tb;
    // Parameters
    parameter WIDTH = 8;

    // Inputs
    reg [WIDTH-1:0] A;
    reg [WIDTH-1:0] B;

    // Outputs
    wire Equal;
    wire Greater;
    wire Less;

    // Instantiate DUT
    param_comparator #(WIDTH) dut (
       .A(A),
       .B(B),
       .Equal(Equal),
       .Greater(Greater),
       .Less(Less)
    );

    initial begin
        // Initialize inputs
        A = 0;
        B = 0;

        // Monitor outputs
        $monitor($time, "A = %b, B = %b, Equal = %b, Greater = %b, Less = %b", A, B, Equal, Greater, Less);

        // Test cases
        #10; // Wait for 10 time units
        A = 5; B = 5; // Equal
        #10;
        A = 6; B = 5; // Greater
        #10;
        A = 4; B = 5; // Less
        #10;
        A = 0; B = 0; // Both zero
        #10;
        A = 255; B = 254; // Max value
        #10;
        A = -1; B = -2; // Min value
        #100; // End of test
    end

    always #5 A = ~A; // Toggle A
    always #5 B = ~B; // Toggle B
endmodule