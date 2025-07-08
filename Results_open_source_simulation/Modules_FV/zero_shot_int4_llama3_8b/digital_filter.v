module tb_digital_filter;
    import "DVLIB::sva_pkg::*";

    parameter DATA_WIDTH = 16;
    parameter COEFF_WIDTH = 16;
    parameter NUM_TAPS = 32;

    logic clk;
    logic rst;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;
    logic [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

    digital_filter dut (
       .clk(clk),
       .rst(rst),
       .data_in(data_in),
       .data_out(data_out),
       .coeff(coeff)
    );

    property p_data_in_range;
       !((data_in > (1 << (DATA_WIDTH - 1)) - 1) | (data_in < -(1 << (DATA_WIDTH - 1)))) -> $rose(rst);

    property p_coeff_range;
       !((coeff[i] > (1 << (COEFF_WIDTH - 1)) - 1) | (coeff[i] < -(1 << (COEFF_WIDTH - 1))) for (i = 0; i < NUM_TAPS));

    property p_data_out_range;
       !((data_out > (1 << (DATA_WIDTH - 1)) - 1) | (data_out < -(1 << (DATA_WIDTH - 1)));

    property p_clk_domain;
        @(posedge clk) disable iff (!rst) data_out == 0;

    property p_rst_reset;
        @(negedge rst) disable iff (!rst) data_out == 0;

    property p_data_in_transition;
       !((data_in!= data_in) ##1);

    property p_coeff_transition;
       !((coeff[i]!= coeff[i]) ##1 for (i = 0; i < NUM_TAPS));

    property p_data_out_transition;
       !((data_out!= data_out) ##1);

    assert property (p_data_in_range);
    assert property (p_coeff_range);
    assert property (p_data_out_range);
    assert property (p_clk_domain);
    assert property (p_rst_reset);
    assert property (p_data_in_transition);
    assert property (p_coeff_transition);
    assert property (p_data_out_transition);

    always @ (posedge clk) begin
        clk <= ~clk;
    end

    initial begin
        rst <= 1'b1;
        repeat (10) @(posedge clk);
        rst <= 1'b0;
        repeat (10) @(posedge clk);
        rst <= 1'b1;
        repeat (10) @(posedge clk);
    end
endmodule