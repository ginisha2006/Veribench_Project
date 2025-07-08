module bidir_pin_tb;

  reg [0:0] pin;
  reg dir;
  reg [0:0] data_out;
  wire [0:0] data_in;

  bidir_pin #(
    .WIDTH(1)
  ) dut (
    .pin(pin),
    .dir(dir),
    .data_out(data_out),
    .data_in(data_in)
  );

  initial begin
    $monitor("Time: %t, dir: %b, data_out: %b, pin: %b, data_in: %b", $time, dir, data_out, pin, data_in);
    dir = 0;
    data_out = 1'b0;
    #10;
    dir = 1;
    data_out = 1'b1;
    #10;
    dir = 0;
    data_out = 1'b1;
    #10;
  end

endmodule