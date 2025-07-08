module tb_param_comparator;

parameter WIDTH = 8;
reg [WIDTH-1:0] A, B;
wire Equal, Greater, Less;

param_comparator #(WIDTH) uut (
   .A(A),
   .B(B),
   .Equal(Equal),
   .Greater(Greater),
   .Less(Less)
);

initial begin
    // Initialize inputs
    A = 0; B = 0;
    #10;

    // Test equal condition
    A = 5; B = 5;
    $monitor($time, "A = %b, B = %b, Equal = %b", A, B, Equal);
    #20;

    // Test greater condition
    A = 10; B = 5;
    $monitor($time, "A = %b, B = %b, Greater = %b", A, B, Greater);
    #20;

    // Test less condition
    A = 5; B = 10;
    $monitor($time, "A = %b, B = %b, Less = %b", A, B, Less);
    #20;

    // Test all conditions
    A = 15; B = 15;
    $monitor($time, "A = %b, B = %b, Equal = %b, Greater = %b, Less = %b", A, B, Equal, Greater, Less);
    #20;

    // Test edge cases
    A = 255; B = 255;
    $monitor($time, "A = %b, B = %b, Equal = %b, Greater = %b, Less = %b", A, B, Equal, Greater, Less);
    #20;

    A = 0; B = 0;
    $monitor($time, "A = %b, B = %b, Equal = %b, Greater = %b, Less = %b", A, B, Equal, Greater, Less);
    #20;

    // Test corner cases
    A = 127; B = 128;
    $monitor($time, "A = %b, B = %b, Equal = %b, Greater = %b, Less = %b", A, B, Equal, Greater, Less);
    #20;

    A = 129; B = 130;
    $monitor($time, "A = %b, B = %b, Equal = %b, Greater = %b, Less = %b", A, B, Equal, Greater, Less);
    #20;

    // Finalize
    $display("Test completed");
    $stop;
end

endmodule