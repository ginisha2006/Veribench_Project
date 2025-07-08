module tb_digital_filter;
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

always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    ##[10:0];
    @(negedge clk) disable iff (!rst));
always @(*) begin assert (($onehot0 {coeff[i]} for i < NUM_TAPS)); end
always @(*) begin assert (($onehot0 {data_in[i]} for i < DATA_WIDTH)); end
always @(*) begin assert (($onehot0 {data_out[i]} for i < DATA_WIDTH)); end
always @(*) begin assert (!rst |=>!data_out); end
always @(*) begin assert (@(posedge clk) disable iff (!rst); end
    data_in == 0 |-> data_out == 0;
    @(posedge clk) disable iff (!rst);
    data_in == 1'b1 |-> data_out == 1'b1);
always @(*) begin assert (data_in >= 2**DATA_WIDTH - 1 |-> data_out == data_in); end
always @(*) begin assert (data_in <= 0 |-> data_out == 0); end

endmodule