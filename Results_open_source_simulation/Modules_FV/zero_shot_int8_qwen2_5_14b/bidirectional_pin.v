module tb_bidir_pin();

   // Signal Declarations
   reg dir;
   reg [3:0] data_out;
   wire [3:0] data_in;
   tri [3:0] pin;

   // DUT Instantiation
   bidir_pin #(.WIDTH(4)) uut (
       .pin(pin),
       .dir(dir),
       .data_out(data_out),
       .data_in(data_in)
   );

   // Clock Generation
   reg clk;
   always #5 clk = ~clk;

   // Properties
   property p_dir_true;
      @(posedge clk) dir |-> !$isunknown(data_out);
   endproperty
   assert property(p_dir_true);

   property p_dir_false;
      @(posedge clk) !dir |-> data_in == '{4{1'bz}};
   endproperty
   assert property(p_dir_false);

   property p_data_pass_through;
      @(posedge clk) dir |=> data_in == data_out;
   endproperty
   assert property(p_data_pass_through);

   property p_z_drive;
      @(posedge clk) !dir |-> !$isunknown(data_in[0]) || !$isunknown(data_in[1]) ||
                              !$isunknown(data_in[2]) || !$isunknown(data_in[3]);
   endproperty
   assert property(p_z_drive);

endmodule