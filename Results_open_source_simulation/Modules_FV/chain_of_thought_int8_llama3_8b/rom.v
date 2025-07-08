module tb_rom_simple;

import "DPI-C" function void readmemh(string filename, reg [7:0][255:0] mem);

reg [7:0] addr;

reg [7:0] data_out;

rom_simple #(.DATA_WIDTH(8),.ADDR_WIDTH(8)) dut (.addr(addr),.data_out(data_out));

property p_read_valid_addr_range;
   !(addr >= (1 << dut.ADDR_WIDTH) || addr < 0);
endproperty

property p_read_valid_data_width;
    data_out <= [dut.DATA_WIDTH-1:0];
endproperty

property p_read_correct_data;
    @(posedge clk) disable iff (!p_read_valid_addr_range) data_out == mem[dut.addr];
endproperty

property p_write_invalid_addr;
   !($onehot(dut.addr));
endproperty

property p_write_invalid_data_width;
   !($onehot(data_out));
endproperty

assert property (@(posedge clk) p_read_valid_addr_range);
assert property (@(posedge clk) p_read_valid_data_width);
assert property (@(posedge clk) p_read_correct_data);
assert property (@(posedge clk) p_write_invalid_addr);
assert property (@(posedge clk) p_write_invalid_data_width);

endmodule