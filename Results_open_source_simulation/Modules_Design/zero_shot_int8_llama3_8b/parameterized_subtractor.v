module param_subtractor #(parameter WIDTH = 8)
    (
        input [WIDTH-1:0] a,
        input [WIDTH-1:0] b,
        output [WIDTH-1:0] diff,
        output borrow
    );
    reg [WIDTH:0] acc;
    always @(posedge clock)
        begin
            if (a >= b)
                acc <= a - b;
            else
                begin
                    borrow <= 1'b1;
                    acc <= (WIDTH) - b + a;
                end
        end
    assign diff = acc[WIDTH-1:0];
    assign borrow = acc[WIDTH];
endmodule