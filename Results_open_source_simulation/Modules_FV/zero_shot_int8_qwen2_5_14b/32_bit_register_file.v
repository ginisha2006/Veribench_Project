module tb_reg_file_32bit (
    input clk,
    input rst,
    input we,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

reg_file_32bit dut (
    .clk(clk),
    .rst(rst),
    .we(we),
    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

property reset_behavior;
    @(posedge clk) disable iff (!rst)
    rst |-> ##1 read_data1 == 32'b0 && read_data2 == 32'b0;
endproperty
assert property(reset_behavior);

property write_enable;
    @(posedge clk) disable iff (!we || !rst)
    we && (write_addr != 5'd0) |-> ##1 read_data1[write_addr] == write_data && read_data2[write_addr] == write_data;
endproperty
assert property(write_enable);

property address_bounds;
    @(posedge clk) disable iff (!rst)
    !(read_addr1 >= 5'd32 || read_addr2 >= 5'd32 || write_addr >= 5'd32);
endproperty
assert property(address_bounds);

property data_stability;
    @(posedge clk) disable iff (!rst)
    !we |-> read_data1[*] == read_data1[*]'prev && read_data2[*] == read_data2[*]'prev;
endproperty
assert property(data_stability);

property write_overwrite;
    @(posedge clk) disable iff (!rst)
    we && (write_addr == read_addr1) |-> ##1 read_data1 == write_data;
endproperty
assert property(write_overwrite);

property write_read_consistency;
    @(posedge clk) disable iff (!rst)
    we && (write_addr == read_addr2) |-> ##1 read_data2 == write_data;
endproperty
assert property(write_read_consistency);

endmodule