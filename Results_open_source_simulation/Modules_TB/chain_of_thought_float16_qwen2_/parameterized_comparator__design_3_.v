module tb_param_comparator;
    reg [7:0] A;
    reg [7:0] B;
    wire Equal;
    wire Greater;
    wire Less;

    initial begin
        param_comparator #(.WIDTH(8)) uut (
            .A(A),
            .B(B),
            .Equal(Equal),
            .Greater(Greater),
            .Less(Less)
        );
        
        // Initialize signals
        A = 8'b0000_0000;
        B = 8'b0000_0000;
        #10
        
        // Test case 1: A == B
        A = 8'b0000_0001;
        B = 8'b0000_0001;
        #10
        
        // Test case 2: A > B
        A = 8'b0000_0101;
        B = 8'b0000_0010;
        #10
        
        // Test case 3: A < B
        A = 8'b0000_0010;
        B = 8'b0000_0101;
        #10
        
        // Edge case: Maximum value comparison
        A = 8'b1111_1111;
        B = 8'b1111_1110;
        #10
        
        // Corner case: Minimum value comparison
        A = 8'b0000_0000;
        B = 8'b0000_0001;
        #10
        
        // Corner case: Zero comparison
        A = 8'b0000_0000;
        B = 8'b0000_0000;
        #10
        
        // Random values
        A = 8'b1010_1010;
        B = 8'b1111_0000;
        #10
        
        // Final state
        $finish;
    end
    
    always @(posedge $anyseq(A) or posedge $anyseq(B)) begin
        $display("A=%b, B=%b, Equal=%b, Greater=%b, Less=%b", A, B, Equal, Greater, Less);
    end
endmodule