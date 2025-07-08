module param_comparator_tb;
    // Parameters
    localparam WIDTH = 8;

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
        $monitor($time, "A = %h, B = %h, Equal = %b, Greater = %b, Less = %b", A, B, Equal, Greater, Less);

        #10; // Wait for some time

        // Test case 1: A == B
        A = 5;
        B = 5;
        #10;

        // Test case 2: A > B
        A = 10;
        B = 5;
        #10;

        // Test case 3: A < B
        A = 3;
        B = 10;
        #10;

        // Test case 4: A == 0, B!= 0
        A = 0;
        B = 5;
        #10;

        // Test case 5: A!= 0, B == 0
        A = 5;
        B = 0;
        #10;

        // Test case 6: A == 0, B == 0
        A = 0;
        B = 0;
        #10;

        // Test case 7: A is max value, B is min value
        A = (1 << WIDTH) - 1;
        B = 0;
        #10;

        // Test case 8: A is min value, B is max value
        A = 0;
        B = (1 << WIDTH) - 1;
        #10;

        // Test case 9: A is same as B but with different bits set
        A = 5'hF;
        B = 5'hF;
        #10;

        // Test case 10: A is same as B but with different bits set
        A = 5'heF;
        B = 5'heF;
        #100; // End of testing
    end

    initial begin
        #100 $finish; // Finish simulation after 100 units of time
    end
endmodule