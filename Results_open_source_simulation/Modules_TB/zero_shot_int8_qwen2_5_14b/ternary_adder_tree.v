module tb_ternary_adder_tree;
    parameter WIDTH = 16;
    
    reg [WIDTH-1:0] A, B, C, D, E;
    reg CLK;
    wire [WIDTH-1:0] OUT;
    
    initial begin
        // Initialize inputs
        A = 0; B = 0; C = 0; D = 0; E = 0;
        #10 CLK = 0;
        
        // Test case 1: All zeros
        #10 {A,B,C,D,E} = 16'b0000000000000000;
        #10 CLK = ~CLK;
        
        // Test case 2: Full range values
        #10 {A,B,C,D,E} = 16'b1111111111111111;
        #10 CLK = ~CLK;
        
        // Test case 3: Random values
        #10 {A,B,C,D,E} = 16'b1010101010101010;
        #10 CLK = ~CLK;
        
        // Test case 4: Edge case - max value for some inputs
        #10 {A,B,C,D,E} = 16'b0000000011111111;
        #10 CLK = ~CLK;
        
        // Test case 5: Edge case - min value for some inputs
        #10 {A,B,C,D,E} = 16'b1111111100000000;
        #10 CLK = ~CLK;
        
        // Test case 6: Mixed values
        #10 {A,B,C,D,E} = 16'b1011010110101010;
        #10 CLK = ~CLK;
        
        // Final clock cycle
        #10 CLK = ~CLK;
        
        // Finish simulation
        #10 $finish;
    end
    
    always #5 CLK = ~CLK;
    
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
        $monitor($time," ns | A=%b, B=%b, C=%b, D=%b, E=%b, OUT=%b", A, B, C, D, E, OUT);
    end
endmodule