module tb_counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
    // Functional Correctness
    assert (@(posedge clk) disable iff (!reset)
        ($rose(reset)) |-> (result == 8'b0));

    assert (@(posedge clk) disable iff (!reset)
        (ena && !reset) |-> (result === result[6:0] ? result : result + 1));

    // Edge Cases
    assert (@(posedge clk) disable iff (!reset)
        (ena && reset) |-> (result == 8'b0));

    // Overflows/Underflows
    assert (@(posedge clk) disable iff (!reset)
        (ena && !reset) |-> (result != 8'hff || result == 8'h00));

    // Illegal Transitions
    assert (@(posedge clk) disable iff (!reset)
        (ena && !reset) |-> (result < 8'hff));
    
    // Clock Signal Generation
    always begin
        #5 clk = ~clk;
    end
    
    // Instantiate DUT
    counter uut (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .result(result)
    );
endmodule