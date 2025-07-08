module bidir_pin_tb #(
    parameter WIDTH = 1
);

  reg [WIDTH-1:0] data_out;
  reg dir;
  wire [WIDTH-1:0] pin;
  wire [WIDTH-1:0] data_in;

  bidir_pin #(WIDTH) dut (
    .pin(pin),
    .dir(dir),
    .data_out(data_out),
    .data_in(data_in)
  );

  initial begin
    $monitor("Time: %t, dir: %b, data_out: %h, pin: %h, data_in: %h", $time, dir, data_out, pin, data_in);
    #10 dir = 1'b0; data_out = 3'b101;
    #10 dir = 1'b1; data_out = 3'b010;
    #10 dir = 1'b0; data_out = 3'b111;
    #10 $finish;
  end

endmodule