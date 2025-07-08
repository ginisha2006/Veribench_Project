module tb_fibonacci_gen #(
    parameter WIDTH = 8
)(
);
    wire clk;
    wire rst;
    wire start;
    wire [WIDTH-1:0] n;
    reg [WIDTH-1:0] fib;
    
    fibonacci_gen uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .n(n),
        .fib(fib)
    );

    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    
    assert (@(posedge clk) disable iff (!rst) 
        (rst && !start) |-> (fib == 0));

    assert (@(posedge clk) disable iff (!rst) 
        (start && rst) |-> ##[1:$] (fib != 0));

    assert (@(posedge clk) disable iff (!rst) 
        (start && rst) |-> ##[1:$] (fib == fibonacci(n)));

    function automatic logic [WIDTH-1:0] fibonacci(input logic [WIDTH-1:0] x);
        case(x)
            0: return 0;
            1: return 1;
            default: return fibonacci(x - 1) + fibonacci(x - 2);
        endcase
    endfunction
endmodule