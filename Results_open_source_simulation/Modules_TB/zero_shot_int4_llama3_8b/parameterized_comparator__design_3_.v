module tb_param_comparator;
parameter WIDTH = 8;

localparam TEST_CASES = 10;

reg [WIDTH-1:0] A;
reg [WIDTH-1:0] B;
wire Equal;
wire Greater;
wire Less;

initial begin
    // Initialize inputs
    A = 0;
    B = 0;

    // Test all possible combinations of A and B values
    for (int i = 0; i < TEST_CASES; i++) begin
        #100; // delay between test cases

        // Generate random values for A and B
        A = $random % (2**WIDTH - 1);
        B = $random % (2**WIDTH - 1);

        // Check equal condition
        if (A == B) begin
            $display("Test case %d: A == B", i+1);
            $display("Expected: Equal = 1");
            $display("Actual:   %b", Equal);
            assert(Equal == 1);
        end

        // Check greater condition
        if (A > B) begin
            $display("Test case %d: A > B", i+1);
            $display("Expected: Greater = 1");
            $display("Actual:   %b", Greater);
            assert(Greater == 1);
        end

        // Check less condition
        if (A < B) begin
            $display("Test case %d: A < B", i+1);
            $display("Expected: Less = 1");
            $display("Actual:   %b", Less);
            assert(Less == 1);
        end
    end

    // Verify that all outputs are reset to 0 when both inputs are 0
    A = 0;
    B = 0;
    #100;
    $display("Expected: Equal = 0, Greater = 0, Less = 0");
    $display("Actual:   %b %b %b", Equal, Greater, Less);
    assert(Equal == 0 && Greater == 0 && Less == 0);

    $finish;
end

$monitor($time, "A = %b, B = %b, Equal = %b, Greater = %b, Less = %b",
         A, B, Equal, Greater, Less);

endmodule