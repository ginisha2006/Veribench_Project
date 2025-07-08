module tb_param_subtractor(
    parameter WIDTH = 8
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

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            ({1'b0,a} - b == {borrow,diff}));

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            (a < b |-> borrow === 1'b1));

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            (a >= b |-> borrow === 1'b0));

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            ((a == 'd0 & b == 'd1) |-> borrow === 1'b1));

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            ((a == 'd255 & b == 'd256) |-> borrow === 1'b1 && diff == 'd255));

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            ((a == 'd0 & b == 'd0) |-> borrow === 1'b0 && diff == 'd0));

endmodule