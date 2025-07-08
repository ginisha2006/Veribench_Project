module param_shift_reg #(parameter WIDTH = 8)(clk, rst, load, data_in, data_out);

input clk;
input rst;
input load;
input [WIDTH-1:0] data_in;

reg [WIDTH-1:0] reg_data;

always @(posedge clk) begin
    if (rst) reg_data <= 0;
    else if (load) reg_data <= data_in;
    else reg_data <= {reg_data[WIDTH-2:0], reg_data[WIDTH-1]};
end

assign data_out = reg_data;

endmodule