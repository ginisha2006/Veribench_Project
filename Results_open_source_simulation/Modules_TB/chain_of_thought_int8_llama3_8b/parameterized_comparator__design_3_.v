module param_comparator_tb;
    // Parameters
    parameter WIDTH = 8;

    // DUT ports
    wire [WIDTH-1:0] A;
    wire [WIDTH-1:0] B;
    wire Equal;
    wire Greater;
    wire Less;

    // Test signals
    reg [WIDTH-1:0] t_A;
    reg [WIDTH-1:0] t_B;

    // Monitor signals
    initial begin
        $monitor($time, "A = %b, B = %b, Equal = %b, Greater = %b, Less = %b", 
                 t_A, t_B, Equal, Greater, Less);
    end

    // Stimulus
    initial begin
        #10; // delay for setup
        t_A = 4'h5; t_B = 4'h5; // equal
        #20;
        t_A = 4'h6; t_B = 4'h5; // greater
        #20;
        t_A = 4'h4; t_B = 4'h6; // less
        #20;
        t_A = 4'ha; t_B = 4'h5; // overflow
        #20;
        t_A = 4'h5; t_B = 4'hf; // underflow
        #100; // finish
    end

    // Instantiate DUT
    param_comparator #(WIDTH) dut (
       .A(t_A),
       .B(t_B),
       .Equal(Equal),
       .Greater(Greater),
       .Less(Less)
    );

endmodule