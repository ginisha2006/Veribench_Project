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
   property p_dir_high;
      @(posedge clk) dir |-> !$isunknown(pin);
   endproperty
   assert property(p_dir_high);

   property p_dir_low;
      @(posedge clk) !dir |-> pin == '{4{1'bz}};
   endproperty
   assert property(p_dir_low);

   property p_data_pass_through;
      @(posedge clk) dir && !$isunknown(data_out) |->
         ##1 data_in == data_out;
   endproperty
   assert property(p_data_pass_through);

   property p_z_state;
      @(posedge clk) !dir || $isunknown(pin);
   endproperty
   assert property(p_z_state);

endmodule