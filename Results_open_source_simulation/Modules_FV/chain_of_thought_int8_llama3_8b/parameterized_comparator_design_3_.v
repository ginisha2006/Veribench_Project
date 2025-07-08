module tb_param_comparator;
    parameter WIDTH = 8;

    logic [WIDTH-1:0] A;
    logic [WIDTH-1:0] B;
    logic Equal;
    logic Greater;
    logic Less;

    param_comparator #(WIDTH) dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

    property p_equal;
        @(posedge clk) ($rose(A) && $rose(B)) |-> (Equal == (A == B));
    endproperty

    property p_greater;
        @(posedge clk) ($rose(A) && $rose(B)) |-> (Greater == (A > B));
    endproperty

    property p_less;
        @(posedge clk) ($rose(A) && $rose(B)) |-> (Less == (A < B));
    endproperty

    property p_edge_cases;
        @(posedge clk) ($fell(A) && $rose(B)) |->!Less;
        @(posedge clk) ($rose(A) && $fell(B)) |->!Greater;
    endproperty

    property p_overflow;
        @(posedge clk) ((A >= 2**WIDTH - 1) || (B >= 2**WIDTH - 1)) |-> (Equal == 1'b0);
    endproperty

    property p_underflow;
        @(posedge clk) ((A <= 2**(-WIDTH + 1)) || (B <= 2**(-WIDTH + 1))) |-> (Equal == 1'b0);
    endproperty

    assert property (p_equal);
    assert property (p_greater);
    assert property (p_less);
    assert property (p_edge_cases);
    assert property (p_overflow);
    assert property (p_underflow);

    always #10 clk = ~clk; // Clock generation

    initial begin
        clk = 0;
        repeat (100) @(posedge clk); // Run for some time
    end

    reg clk;
endmodule