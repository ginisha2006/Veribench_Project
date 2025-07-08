module mod_demod #(
    parameter DATA_WIDTH = 16
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);
    always @(posedge clk or posedge rst)
        if(rst)
            modulated_signal <= {DATA_WIDTH{1'b0}};
        else
            modulated_signal <= ~data_in;
    
    always @(posedge clk or posedge rst)
        if(rst)
            demodulated_data <= {DATA_WIDTH{1'b0}};
        else
            demodulated_data <= ~modulated_signal;
endmodule