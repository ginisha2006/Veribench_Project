module tb_behav_counter(
    input wire clk,
    input wire clear,
    input wire load,
    input wire up_down,
    input wire [7:0] d,
    output reg [7:0] qd
);
    
    // DUT instantiation
    behav_counter dut (
        .d(d),
        .clk(clk),
        .clear(clear),
        .load(load),
        .up_down(up_down),
        .qd(qd)
    );

    // Clock generation
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end
    
    // Properties
    property p_clear_reset;
        @(posedge clk) disable iff(!reset)
            !clear |-> (qd == 8'h00);
    endproperty
    assert property(p_clear_reset); 
    
    property p_load_value;
        @(posedge clk) disable iff(!reset)
            load |-> (qd == d);
    endproperty
    assert property(p_load_value);
    
    property p_up_count;
        @(posedge clk) disable iff(!reset)
            up_down & !load & !clear |-> (qd[7:0] == qd[7:0]+1);
    endproperty
    assert property(p_up_count);
    
    property p_down_count;
        @(posedge clk) disable iff(!reset)
            !up_down & !load & !clear |-> (qd[7:0] == qd[7:0]-1);
    endproperty
    assert property(p_down_count);
    
    property p_underflow;
        @(posedge clk) disable iff(!reset)
            !up_down & !load & !clear & (qd == 8'h00) |-> (qd == 8'hff);
    endproperty
    assert property(p_underflow);
    
    property p_overflow;
        @(posedge clk) disable iff(!reset)
            up_down & !load & !clear & (qd == 8'hff) |-> (qd == 8'h00);
    endproperty
    assert property(p_overflow);
    
endmodule