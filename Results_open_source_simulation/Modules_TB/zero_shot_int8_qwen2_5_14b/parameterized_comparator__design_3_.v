module tb_param_comparator;
    parameter WIDTH = 8;
    reg [WIDTH-1:0] A;
    reg [WIDTH-1:0] B;
    wire Equal;
    wire Greater;
    wire Less;

    initial begin
        // Initialize signals
        A = 0; B = 0;
        #10 A = 5'd7; B = 5'd6; // A > B
        #10 A = 5'd4; B = 5'd4; // A == B
        #10 A = 5'd1; B = 5'd2; // A < B
        #10 A = 5'd0; B = 5'd0; // Edge case - both zero
        #10 A = WIDTH'-1; B = WIDTH'-1; // Max value comparison
        #10 A = 1'b1; B = WIDTH'-1; // Min vs max value
        #10 A = WIDTH'-1; B = 1'b1; // Max vs min value
        #10 A = WIDTH'/2; B = WIDTH'/2 + 1; // Near equal values
        #10 A = WIDTH'-1; B = 1'b0; // Max vs min value
        #10 A = 1'b0; B = WIDTH'-1; // Min vs max value
        #10 $stop;
    end

    initial begin
        $dumpfile("tb_param_comparator.vcd");
        $dumpvars(0, tb_param_comparator);
    end

    param_comparator #(.WIDTH(WIDTH)) uut (
        .A(A),
        .B(B),
        .Equal(Equal),
        .Greater(Greater),
        .Less(Less)
    );

    always @(posedge Equal) $display("Time %t: A(%b) == B(%b)", $time, A, B);
    always @(posedge Greater) $display("Time %t: A(%b) > B(%b)", $time, A, B);
    always @(posedge Less) $display("Time %t: A(%b) < B(%b)", $time, A, B);

endmodule