module tb_digital_filter (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] data_out,
    input [15:0] coeff [31:0]
);

wire clk;
reg rst;
reg [15:0] data_in;
wire [15:0] data_out;
reg [15:0] coeff [31:0];

digital_filter #(.DATA_WIDTH(16), .COEFF_WIDTH(16), .NUM_TAPS(32)) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
);

always begin
    clk = 1'b0;
    #(5ns) clk = 1'b1;
    #(5ns)
end

always @(*) begin assert (@(posedge clk) disable iff (!rst) data_out == 16'd0); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) data_out[*] |-> data_out[*] == data_out[0]); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) coeff[*][*] |-> data_out[*] == data_out[0]); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) data_out inside {[0 : 65535]}); end

always @(*) begin assert (@(posedge clk) disable iff (!rst && &{coeff[*]} && data_in > 0) data_out >= 0); end

always @(*) begin assert (@(posedge clk) disable iff (!rst && &{coeff[*]} && data_in == 16'hFFFF) data_out <= 16'hFFFF); end

always @(*) begin assert (@(posedge clk) disable iff (!rst && {coeff[*]} == 16'h0000 && data_in == 16'h0000) data_out >= 0); end

endmodule