module tb_mod_demod;
import "DPI-C" function void cb();
parameter DATA_WIDTH = 16;

logic clk;
logic rst;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] modulated_signal;
logic [DATA_WIDTH-1:0] demodulated_data;

mod_demod #(
   .DATA_WIDTH(DATA_WIDTH)
) dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .modulated_signal(modulated_signal),
   .demodulated_data(demodulated_data)
);

assert property p_all;

always @ (posedge clk) begin
    clk = ~clk;
    #10;
    clk = ~clk;
    #10;
end

initial begin
    cb();
end

endmodule