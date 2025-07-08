module tb_param_comparator;
    parameter WIDTH = 8;

    logic [WIDTH-1:0] A;
    logic [WIDTH-1:0] B;
    logic Equal;
    logic Greater;
    logic Less;

    param_comparator #(WIDTH) dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

    always @(*) begin assert (@(posedge clk) ($rose(A) && $rose(B)) |-> (Equal == (A == B))); end
    always @(*) begin assert (@(posedge clk) ($rose(A) && $rose(B)) |-> (Greater == (A > B))); end
    always @(*) begin assert (@(posedge clk) ($rose(A) && $rose(B)) |-> (Less == (A < B))); end
    assert (@(posedge clk) ($fell(A) && $rose(B)) |->!Less;
        @(posedge clk) ($rose(A) && $fell(B)) |->!Greater);
    always @(*) begin assert (@(posedge clk) ((A >= 2**WIDTH - 1) || (B >= 2**WIDTH - 1)) |-> (Equal == 1'b0)); end
    always @(*) begin assert (@(posedge clk) ((A <= 2**(-WIDTH + 1)) || (B <= 2**(-WIDTH + 1))) |-> (Equal == 1'b0)); end

    always #10 clk = ~clk; // Clock generation

    initial begin
        clk = 0;
        repeat (100) @(posedge clk); // Run for some time
    end

    reg clk;
endmodule