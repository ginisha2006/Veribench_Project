module reg_file_32bit(clk, rst, we, read_addr1, read_addr2, write_addr, write_data, read_data1, read_data2);

input wire clk;

input wire rst;

input wire [4:0] read_addr1;

input wire [4:0] read_addr2;

input wire [4:0] write_addr;

input wire [31:0] write_data;

output reg [31:0] read_data1;

output reg [31:0] read_data2;

reg [31:0] reg_array [31:0];

always @(posedge clk) begin

if (rst) begin

for (int i = 0; i < 32; i++)

reg_array[i] <= 0;

end else if (we && write_addr!= read_addr1 && write_addr!= read_addr2) begin

reg_array[write_addr] <= write_data;

end

end

assign read_data1 = reg_array[read_addr1];

assign read_data2 = reg_array[read_addr2];

endmodule