module tb_ternary_adder_tree;
    parameter WIDTH = 16;

    reg [WIDTH-1:0] A, B, C, D, E;
    reg CLK;
    wire [WIDTH-1:0] OUT;

    initial begin
        // Initialize inputs
        A = 0; B = 0; C = 0; D = 0; E = 0;
        #10 CLK = 1'b1;
        #5 CLK = 1'b0;
    end

    always #5 CLK = ~CLK;

    initial begin
        // Test case 1: All zeros
        @(negedge CLK) A = 0; B = 0; C = 0; D = 0; E = 0;
        repeat(2) @(posedge CLK);

        // Test case 2: Single bit set in each input
        @(negedge CLK) A = 1; B = 0; C = 0; D = 0; E = 0;
        repeat(2) @(posedge CLK);

        // Test case 3: Multiple bits set in first stage
        @(negedge CLK) A = 4'd7; B = 4'd8; C = 4'd9; D = 4'd10; E = 4'd11;
        repeat(2) @(posedge CLK);

        // Test case 4: Maximum values
        @(negedge CLK) A = {WIDTH{1'b1}}; B = {WIDTH{1'b1}}; C = {WIDTH{1'b1}}; D = {WIDTH{1'b1}}; E = {WIDTH{1'b1}};
        repeat(2) @(posedge CLK);

        // Test case 5: Random values
        @(negedge CLK) A = $random; B = $random; C = $random; D = $random; E = $random;
        repeat(2) @(posedge CLK);

        // Finish simulation
        $finish;
    end

    // Instantiate DUT
    ternary_adder_tree uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .CLK(CLK),
        .OUT(OUT)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_ternary_adder_tree);
    end

    initial begin
        $monitor($time, " ns: A=%b, B=%b, C=%b, D=%b, E=%b, OUT=%b", A, B, C, D, E, OUT);
    end
endmodule