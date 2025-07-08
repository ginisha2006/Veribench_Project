module tb_param_subtractor;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] diff;
    wire borrow;

    param_subtractor #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .diff(diff),
        .borrow(borrow)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0;
        #10;
        $display("Case 1: a=0, b=0");
        $monitor("%d %d %d %b", a, b, diff, borrow);

        a = 5; b = 3;
        #10;
        $display("Case 2: a=5, b=3");
        
        a = 7; b = 9;
        #10;
        $display("Case 3: a=7, b=9");

        a = 'hFF; b = 'hFE;
        #10;
        $display("Case 4: a=%h, b=%h", a, b);

        a = 'hF0; b = 'hFF;
        #10;
        $display("Case 5: a=%h, b=%h", a, b);

        a = 'hFFFF; b = 'hFFF0;
        #10;
        $display("Case 6: a=%h, b=%h", a, b);

        a = 'hFFFF; b = 'hFFFF;
        #10;
        $display("Case 7: a=%h, b=%h", a, b);

        #100;
        $finish;
    end
endmodule