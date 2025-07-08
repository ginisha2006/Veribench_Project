module tb_param_comparator;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] A;
    reg [WIDTH-1:0] B;
    wire Equal;
    wire Greater;
    wire Less;

    initial begin
        param_comparator #(.WIDTH(WIDTH)) uut (
            .A(A),
            .B(B),
            .Equal(Equal),
            .Greater(Greater),
            .Less(Less)
        );

        // Initialize signals
        A = 0; B = 0;
        #10 $monitor("Cycle %d: A=%b, B=%b, Equal=%b, Greater=%b, Less=%b", $time, A, B, Equal, Greater, Less);

        // Test case 1: A == B
        A = 5'd7; B = 5'd7;
        #10;

        // Test case 2: A > B
        A = 5'd10; B = 5'd5;
        #10;

        // Test case 3: A < B
        A = 5'd3; B = 5'd6;
        #10;

        // Edge case: A is max value, B is min value
        A = WIDTH'(2**WIDTH-1); B = WIDTH'('h0);
        #10;

        // Corner case: A is min value, B is max value
        A = WIDTH'('h0); B = WIDTH'(2**WIDTH-1);
        #10;

        // Random values
        A = $random; B = $random;
        #10;

        // Finish simulation
        $finish;
    end
endmodule