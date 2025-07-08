module tb_ternary_adder_tree;
    parameter WIDTH = 16;

    reg [WIDTH-1:0] A, B, C, D, E;
    reg CLK;
    wire [WIDTH-1:0] OUT;

    // Instantiate the design under test
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
        // Initialize inputs
        A = 0; B = 0; C = 0; D = 0; E = 0;
        #10 CLK = 1'b1;
        #10 CLK = 1'b0;

        // Test case 1: All zeros
        @(negedge CLK) begin
            A = 0; B = 0; C = 0; D = 0; E = 0;
        end
        @(negedge CLK) begin
            $display("Test Case 1 - All Zeros: OUT=%b", OUT);
        end

        // Test case 2: Full range values
        @(negedge CLK) begin
            A = 'd32768; B = 'd32768; C = 'd32768; D = 'd32768; E = 'd32768;
        end
        @(negedge CLK) begin
            $display("Test Case 2 - Full Range Values: OUT=%b", OUT);
        end

        // Test case 3: Random values
        @(negedge CLK) begin
            A = $random; B = $random; C = $random; D = $random; E = $random;
        end
        @(negedge CLK) begin
            $display("Test Case 3 - Random Values: OUT=%b", OUT);
        end

        // Test case 4: Edge case with overflow
        @(negedge CLK) begin
            A = 'd65535; B = 'd65535; C = 'd65535; D = 'd65535; E = 'd65535;
        end
        @(negedge CLK) begin
            $display("Test Case 4 - Overflow: OUT=%b", OUT);
        end

        // Finish simulation
        $finish;
    end

    always #5 CLK = ~CLK;

endmodule