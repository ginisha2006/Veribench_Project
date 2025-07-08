module tb_param_comparator;
    reg [7:0] A;
    reg [7:0] B;
    wire Equal;
    wire Greater;
    wire Less;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_param_comparator);

        // Initialize signals
        A = 8'b0000_0000;
        B = 8'b0000_0000;
        
        #10 A = 8'b0000_0001; B = 8'b0000_0000; #10
        #10 A = 8'b0000_0010; B = 8'b0000_0001; #10
        #10 A = 8'b1111_1111; B = 8'b1111_1110; #10
        #10 A = 8'b0000_0000; B = 8'b0000_0001; #10
        #10 A = 8'b1000_0000; B = 8'b1000_0000; #10
        #10 A = 8'b1111_1111; B = 8'b0000_0000; #10
        #10 A = 8'b0000_0001; B = 8'b1111_1111; #10
        
        #50 $finish;
    end
    
    initial begin
        $monitor($time," ns: A=%b, B=%b, Equal=%b, Greater=%b, Less=%b", A, B, Equal, Greater, Less);
    end
    
    param_comparator #(.WIDTH(8)) uut (
        .A(A),
        .B(B),
        .Equal(Equal),
        .Greater(Greater),
        .Less(Less)
    );
    
endmodule