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
    $dumpfile("bidir_pin_sim.vcd");
    $dumpvars(0, bidir_pin_tb);

    #10 dir = 1'b0;
    data_out = 3'b101;
    #10 dir = 1'b1;
    data_out = 3'b010;
    #10;

    $finish;
  end

  always @(posedge clk) begin
    $monitor("Time: %t, dir: %b, data_out: %b, pin: %b, data_in: %b", $time, dir, data_out, pin, data_in);
  end

endmodule