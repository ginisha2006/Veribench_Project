module tb_param_subtractor #(
    parameter WIDTH = 8
)(
);
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic [WIDTH-1:0] diff;
    logic borrow;

    param_subtractor #(.WIDTH(WIDTH)) dut (
        .a(a),
        .b(b),
        .diff(diff),
        .borrow(borrow)
    );

    always begin
        #5 clk = ~clk;
    end

    logic clk;
    assign clk = 1'b1; // Dummy assignment to declare clk

    property p_diff_correctness;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            diff == (a > b ? a - b : {(WIDTH){1'b0}});
    endproperty
    assert property(p_diff_correctness);

    property p_borrow_correctness;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            borrow === (a < b);
    endproperty
    assert property(p_borrow_correctness);

    property p_edge_cases;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            (a == 0 && b != 0) |-> diff == {(WIDTH){1'b0}} & borrow;
    endproperty
    assert property(p_edge_cases);

    property p_overflow_underflow;
        @(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            (!($isunknown(diff))) |-> (diff >= 0) && (diff <= (2**WIDTH)-1);
    endproperty
    assert property(p_overflow_underflow);

endmodule