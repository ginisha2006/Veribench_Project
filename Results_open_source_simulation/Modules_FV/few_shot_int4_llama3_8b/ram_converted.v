module tb_ram_simple #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 8);

  // Clock
  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the DUT
  ram_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) UUT (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Write operation
  always @(*) begin assert (@(posedge clk) ((we &&!$past(we)) => (mem[$signed(addr)] == data_in))); end

  // Property: Read operation
  always @(*) begin assert (@(posedge clk) (!we || (data_out == mem[$signed(addr)]))); end

  // Property: Data retention
  always @(*) begin assert (@(posedge clk) (!we || (data_out === mem[$signed(addr)]))); end

endmodule