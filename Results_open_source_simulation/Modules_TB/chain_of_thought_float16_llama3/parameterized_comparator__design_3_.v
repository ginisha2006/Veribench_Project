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
        $monitor($time, "A=%b, B=%b, Equal=%b, Greater=%b, Less=%b", A, B, Equal, Greater, Less);

        // Test case 1: Equal
        A <= 5; B <= 5; #10;
        A <= 10; B <= 10; #10;
        A <= 255; B <= 255; #10;

        // Test case 2: Greater
        A <= 4; B <= 3; #10;
        A <= 100; B <= 50; #10;
        A <= 200; B <= 150; #10;

        // Test case 3: Less
        A <= 6; B <= 7; #10;
        A <= 20; B <-30; #10;
        A <= 40; B <-60; #10;

        #100 $finish;
    end
endmodule