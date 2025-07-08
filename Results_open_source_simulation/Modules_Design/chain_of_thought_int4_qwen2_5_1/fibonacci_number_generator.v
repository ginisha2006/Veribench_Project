module fibonacci_gen #(
    parameter int WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic start,
    input logic [WIDTH-1:0] n,
    output logic [WIDTH-1:0] fib
);

logic [WIDTH-1:0] fib_prev;
logic [WIDTH-1:0] fib_curr;
logic [WIDTH-1:0] temp;

always_ff @(posedge clk) begin
    if(rst)
        fib <= 'd0;
    else if(start) begin
        fib_prev <= 'd0;
        fib_curr <= 'd1;
        for(int i=0; i<n; i=i+1) begin
            temp = fib_prev + fib_curr;
            fib_prev <= fib_curr;
            fib_curr <= temp;
        end
        fib <= fib_curr;
    end
end

endmodule