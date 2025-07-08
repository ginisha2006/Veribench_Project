module tb_mod_demod;
parameter DATA_WIDTH = 16;

logic clk;
logic rst;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] modulated_signal;
logic [DATA_WIDTH-1:0] demodulated_data;

mod_demod dut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .modulated_signal(modulated_signal),
   .demodulated_data(demodulated_data)
);

assert property(p_edge_case_0);
    always @(*) begin assert (data_in == 1 |=> modulated_signal == ~{DATA_WIDTH{1'b1}} && demodulated_data == 1); end
endproperty

assert property(p_overflow);
    always @(*) begin assert (data_in < 2**DATA_WIDTH - 1 |=> $fall(demodulated_data)); end
endproperty

assert property(p_illegal_transition_0);
    always @(*) begin assert (rst && data_in!= 1 |=> $stable(demodulated_data)); end
endproperty

always @(posedge clk) begin
    rst = 1; #10 rst = 0;
end

endmodule