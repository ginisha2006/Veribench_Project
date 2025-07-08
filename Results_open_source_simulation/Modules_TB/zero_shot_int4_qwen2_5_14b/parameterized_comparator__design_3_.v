module tb_param_comparator;
    reg [7:0] A;
    reg [7:0] B;
    wire Equal;
    wire Greater;
    wire Less;

    param_comparator #(.WIDTH(8)) uut (
        .A(A),
        .B(B),
        .Equal(Equal),
        .Greater(Greater),
        .Less(Less)
    );

    initial begin
        // Initialize inputs
        A = 8'b0000_0000; B = 8'b0000_0000; #10;
        A = 8'b0000_0001; B = 8'b0000_0000; #10;
        A = 8'b1111_1111; B = 8'b0000_0000; #10;
        A = 8'b0000_0000; B = 8'b1111_1111; #10;
        A = 8'b1111_1111; B = 8'b1111_1111; #10;
        A = 8'b0101_0101; B = 8'b1010_1010; #10;
        A = 8'b1010_1010; B = 8'b0101_0101; #10;
        A = 8'b1111_1111; B = 8'b1111_1110; #10;
        A = 8'b1111_1110; B = 8'b1111_1111; #10;
        A = 8'b0000_0001; B = 8'b0000_0010; #10;
        A = 8'b0000_0010; B = 8'b0000_0001; #10;
        A = 8'b1000_0000; B = 8'b0100_0000; #10;
        A = 8'b0100_0000; B = 8'b1000_0000; #10;
        A = 8'b1111_1111; B = 8'b0000_0001; #10;
        A = 8'b0000_0001; B = 8'b1111_1111; #10;
        #50 $stop;
    end

    always @(posedge A || posedge B) begin
        $monitor("%b %b -> E:%b G:%b L:%b", A, B, Equal, Greater, Less);
    end
endmodule