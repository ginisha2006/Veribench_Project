module tb_bidir_pin();

   // Signals declaration
   logic [3:0] clk;
   logic [3:0] dir;
   logic [3:0] data_out;
   logic [3:0] data_in;
   wire [3:0] pin;

   // Clock generation
   always begin
      clk <= ~clk;
      #(5ns);
   end
   
   // DUT instantiation
   bidir_pin #(.WIDTH(4)) uut (
       .pin(pin),
       .dir(dir),
       .data_out(data_out),
       .data_in(data_in)
   );

   // Properties
   always @(*) begin assert (@(posedge clk) dir |-> !$isunknown(pin)); end

   always @(*) begin assert (@(posedge clk) !dir |-> pin == '{4{1'bz}}); end

   assert (@(posedge clk) dir && !$isunknown(data_out) |->
         ##1 data_in == data_out);

   always @(*) begin assert (@(posedge clk) !dir || $isunknown(pin)); end

endmodule