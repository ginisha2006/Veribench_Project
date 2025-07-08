module tb_binary_adder_tree;
    reg        [15:0] A, B, C, D, E;
    reg               clk;
    wire       [15:0] out;

    initial begin
        // Initialize inputs
        A = 16'b0; B = 16'b0; C = 16'b0; D = 16'b0; E = 16'b0;
        clk = 0;
        
        #10 A = 16'd1024; B = 16'd512; C = 16'd256; D = 16'd128; E = 16'd64;
        #10 A = 16'd-1024; B = 16'd-512; C = 16'd-256; D = 16'd-128; E = 16'd-64;
        #10 A = 16'hFFFF; B = 16'hAAAA; C = 16'hBBBB; D = 16'hCCCC; E = 16'hDDDD;
        #10 A = 16'h0000; B = 16'h0000; C = 16'h0000; D = 16'h0000; E = 16'h0000;
        #10 A = 16'd7000; B = 16'd8000; C = 16'd9000; D = 16'd10000; E = 16'd11000;
        
        // Stop after all tests
        #100 $stop;
    end
    
    always #5 clk = ~clk;

    binary_adder_tree uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E),
        .clk(clk),
        .out(out)
    );

    initial begin
        $dumpfile("tb_binary_adder_tree.vcd");
        $dumpvars(0, tb_binary_adder_tree);
    end

    initial begin
        #1 $monitor($time," ns | A=%b, B=%b, C=%b, D=%b, E=%b, out=%b", A, B, C, D, E, out);
    end
endmodule