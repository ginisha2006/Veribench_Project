module mod_demod #(
    parameter DATA_WIDTH = 16
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

reg [DATA_WIDTH-1:0] prev_data;
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        prev_data <= 0;
        modulated_signal <= 0;
        demodulated_data <= 0;
    end
    else
    begin
        prev_data <= data_in;
        modulated_signal <= data_in ^ {prev_data[DATA_WIDTH-2:0],prev_data[DATA_WIDTH-1]};
        demodulated_data <= modulated_signal ^ {modulated_signal[DATA_WIDTH-2:0],modulated_signal[DATA_WIDTH-1]};
    end
end

endmodule