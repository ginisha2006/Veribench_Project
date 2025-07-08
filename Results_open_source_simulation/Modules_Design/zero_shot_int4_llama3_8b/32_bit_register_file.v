module reg_file_32bit;
input [0:0] clk,
         rst,
         we,
         read_addr1[4:0],
         read_addr2[4:0],
         write_addr[4:0],
         write_data[31:0];
output reg [31:0] read_data1,
                  read_data2;

reg [31:0] reg_array [31:0];

always @(posedge clk)
begin
    if (rst) begin
        for (int i = 0; i < 32; i++) reg_array[i] <= 0;
    end else if (we) begin
        reg_array[write_addr] <= write_data;
    end
end

assign read_data1 = reg_array[read_addr1];
assign read_data2 = reg_array[read_addr2];

endmodule