module reg_file_32bit (
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

  reg [31:0] reg_array [0:31];

  always @(posedge clk) begin
    if (rst) begin
      for (int i = 0; i < 32; i++) begin
        reg_array[i] <= 0;
      end
    end else if (we) begin
      reg_array[write_addr] <= write_data;
    end
  end

  assign read_data1 = reg_array[read_addr1];
  assign read_data2 = reg_array[read_addr2];

endmodule