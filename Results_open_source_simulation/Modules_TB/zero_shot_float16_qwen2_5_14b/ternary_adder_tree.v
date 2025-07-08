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
        // Initialize Inputs
        A = 0; B = 0; C = 0; D = 0; E = 0;
        CLK = 0;

        #10 A = 8'd3; B = 8'd4; C = 8'd5; D = 8'd6; E = 8'd7;
        #10 A = 8'd10; B = 8'd11; C = 8'd12; D = 8'd13; E = 8'd14;
        #10 A = 8'hff; B = 8'hfe; C = 8'hfd; D = 8'hfc; E = 8'fhf;
        #10 A = 8'd0; B = 8'd0; C = 8'd0; D = 8'd0; E = 8'd0;
        #10 A = 8'd1; B = 8'd1; C = 8'd1; D = 8'd1; E = 8'd1;
        #10 A = 8'd99; B = 8'd98; C = 8'd97; D = 8'd96; E = 8'd95;
        
        #10 $finish;
    end

    always #5 CLK = ~CLK;

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_ternary_adder_tree);

        #100 $finish;
    end

    always @(posedge CLK) begin
        $monitor("%t: A=%b, B=%b, C=%b, D=%b, E=%b, OUT=%b", $time, A, B, C, D, E, OUT);
    end
endmodule