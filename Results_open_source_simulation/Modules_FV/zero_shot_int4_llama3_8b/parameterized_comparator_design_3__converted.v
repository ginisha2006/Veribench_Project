module tb_param_comparator;
    // Parameters
    localparam WIDTH = 8;

    // Input/Output signals
    logic [WIDTH-1:0] A;
    logic [WIDTH-1:0] B;
    logic Equal;
    logic Greater;
    logic Less;

    // DUT instantiation
    param_comparator dut (.A(A),.B(B),.Equal(Equal),.Greater(Greater),.Less(Less));

    // Clock signal generation
    always #10 clk = ~clk; // Non-inverting clock

    // Properties
    always @(*) begin assert (@(posedge clk) ($rose(A) && $fell(B)) |-> (Equal)); end
    always @(*) begin assert (@(posedge clk) ($rose(A) && $fell(B)) |-> (Greater)); end
    always @(*) begin assert (@(posedge clk) ($rose(A) && $fell(B)) |-> (Less)); end
    always @(*) begin assert (@(posedge clk) ($signed(A) > $max_value($signed(A))) |-> ($rose(Greater))); end
    always @(*) begin assert (@(posedge clk) ($signed(A) < $min_value($signed(A))) |-> ($rose(Less))); end

endmodule