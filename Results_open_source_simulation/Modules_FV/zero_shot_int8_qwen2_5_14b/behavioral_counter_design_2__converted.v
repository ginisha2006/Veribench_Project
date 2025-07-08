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
    assert (@(posedge clk) disable iff(!reset)
            !clear |-> (qd == 8'h00)); 
    
    assert (@(posedge clk) disable iff(!reset)
            load |-> (qd == d));
    
    assert (@(posedge clk) disable iff(!reset)
            up_down & !load & !clear |-> (qd[7:0] == qd[7:0]+1));
    
    assert (@(posedge clk) disable iff(!reset)
            !up_down & !load & !clear |-> (qd[7:0] == qd[7:0]-1));
    
    assert (@(posedge clk) disable iff(!reset)
            !up_down & !load & !clear & (qd == 8'h00) |-> (qd == 8'hff));
    
    assert (@(posedge clk) disable iff(!reset)
            up_down & !load & !clear & (qd == 8'hff) |-> (qd == 8'h00));
    
endmodule