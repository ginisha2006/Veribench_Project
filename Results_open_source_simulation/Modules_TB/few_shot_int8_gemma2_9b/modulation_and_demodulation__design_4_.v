module tb_mod_demod;
// Parameters
parameter DATA_WIDTH = 16;
// Inputs
reg clk;
reg rst;
reg [DATA_WIDTH-1:0] data_in;
// Outputs
wire [DATA_WIDTH-1:0] modulated_signal;
wire [DATA_WIDTH-1:0] demodulated_data;
// Instantiate the Modulator/Demodulator
mod_demod #( .DATA_WIDTH(DATA_WIDTH) ) uut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .modulated_signal(modulated_signal),
    .demodulated_data(demodulated_data)
);
initial begin
    clk = 0; forever #5 clk = ~clk;
    rst = 1; #10 rst = 0;
    // Test Cases
    data_in = 0; #10;
    data_in = 16'hAAAA; #10;
    data_in = 16'hFFFF; #10;
    data_in = 16'h0000; #10;
    $finish;
end
initial begin
    $dumpfile("tb_mod_demod.vcd");
    $dumpvars(0, tb_mod_demod);
end
endmodule