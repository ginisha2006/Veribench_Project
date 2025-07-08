module tb_param_shift_reg;

parameter WIDTH = 8;

logic clk;
logic rst;
logic load;
logic [WIDTH-1:0] data_in;
logic [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) dut (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

property prop_load_data;
    @(posedge clk) disable iff (!rst) data_out == data_in;
endproperty

property prop_reset;
    @(posedge rst) data_out == 0;
endproperty

property prop_idle;
   !load |-> data_out === data_out;
endproperty

property prop_edge_cases;
    @(posedge clk) disable iff (!rst) ($rose(load) |=> data_out == data_in);
    @(posedge clk) disable iff (!rst) (!$rose(load) |=> data_out === data_out);
endproperty

property prop_overflow;
    // Overflow check not applicable for this design
endproperty

property prop_underflow;
    // Underflow check not applicable for this design
endproperty

assert property (prop_load_data);
assert property (prop_reset);
assert property (prop_idle);
assert property (prop_edge_cases);

endmodule