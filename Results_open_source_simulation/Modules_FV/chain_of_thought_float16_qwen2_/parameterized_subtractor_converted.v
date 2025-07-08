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

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            diff == (a > b ? a - b : {(WIDTH){1'b0}}));

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            borrow === (a < b));

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            (a == 0 && b != 0) |-> diff == {(WIDTH){1'b0}} & borrow);

    assert (@(posedge clk) disable iff ($isunknown(a) || $isunknown(b))
            (!($isunknown(diff))) |-> (diff >= 0) && (diff <= (2**WIDTH)-1));

endmodule