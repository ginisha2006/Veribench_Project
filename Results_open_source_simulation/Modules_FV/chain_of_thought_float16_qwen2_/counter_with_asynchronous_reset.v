module tb_counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
    // Functional Correctness
    property p_func_correctness;
        @(posedge clk) disable iff (!reset)
        ($rose(reset)) |-> (result == 8'b0);
    endproperty
    assert property(p_func_correctness);

    property p_increment_on_ena;
        @(posedge clk) disable iff (!reset)
        (ena && !reset) |-> (result === result[6:0] ? result : result + 1);
    endproperty
    assert property(p_increment_on_ena);

    // Edge Cases
    property p_reset_during_count;
        @(posedge clk) disable iff (!reset)
        (ena && reset) |-> (result == 8'b0);
    endproperty
    assert property(p_reset_during_count);

    // Overflows/Underflows
    property p_no_underflow;
        @(posedge clk) disable iff (!reset)
        (ena && !reset) |-> (result != 8'hff || result == 8'h00);
    endproperty
    assert property(p_no_underflow);

    // Illegal Transitions
    property p_legal_transitions;
        @(posedge clk) disable iff (!reset)
        (ena && !reset) |-> (result < 8'hff);
    endproperty
    assert property(p_legal_transitions);
    
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