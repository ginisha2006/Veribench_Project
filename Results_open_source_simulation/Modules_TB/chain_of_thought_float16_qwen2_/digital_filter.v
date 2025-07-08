module tb_digital_filter;
    parameter DATA_WIDTH = 16;
    parameter COEFF_WIDTH = 16;
    parameter NUM_TAPS = 32;

    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    reg [COEFF_WIDTH-1:0] coeff[NUM_TAPS-1:0];

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1; 
        repeat(2) @(posedge clk);
        rst = 0;
    end

    initial begin
        $dumpfile("digital_filter.vcd");
        $dumpvars(0, tb_digital_filter);

        coeff[0] = 8'd1; coeff[1] = 8'd2; coeff[2] = 8'd3; coeff[3] = 8'd4;
        coeff[4] = 8'd5; coeff[5] = 8'd6; coeff[6] = 8'd7; coeff[7] = 8'd8;
        coeff[8] = 8'd9; coeff[9] = 8'd10; coeff[10] = 8'd11; coeff[11] = 8'd12;
        coeff[12] = 8'd13; coeff[13] = 8'd14; coeff[14] = 8'd15; coeff[15] = 8'd16;
        coeff[16] = 8'd17; coeff[17] = 8'd18; coeff[18] = 8'd19; coeff[19] = 8'd20;
        coeff[20] = 8'd21; coeff[21] = 8'd22; coeff[22] = 8'd23; coeff[23] = 8'd24;
        coeff[24] = 8'd25; coeff[25] = 8'd26; coeff[26] = 8'd27; coeff[27] = 8'd28;
        coeff[28] = 8'd29; coeff[29] = 8'd30; coeff[30] = 8'd31; coeff[31] = 8'd32;

        data_in = 16'd0;
        repeat(10) @(posedge clk);
        data_in = 16'd100;
        repeat(10) @(posedge clk);
        data_in = 16'd200;
        repeat(10) @(posedge clk);
        data_in = 16'hFFFF;
        repeat(10) @(posedge clk);
        data_in = 16'd0;
        repeat(10) @(posedge clk);

        $finish;
    end

    always @(posedge clk) if (!rst) $monitor($time," Data Out: %d", data_out);
    
    digital_filter #(.DATA_WIDTH(DATA_WIDTH), .COEFF_WIDTH(COEFF_WIDTH), .NUM_TAPS(NUM_TAPS)) dut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out),
        .coeff(coeff)
    );
endmodule