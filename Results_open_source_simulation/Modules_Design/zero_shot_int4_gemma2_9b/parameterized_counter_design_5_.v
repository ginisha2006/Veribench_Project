module param_counter(clk, rst, count);

  parameter MAX_COUNT = 255;
  reg [7:0] counter;

  always @(posedge clk or posedge rst) begin
    if (rst)
      counter <= 0;
    else if (counter == MAX_COUNT)
      counter <= 0;
    else
      counter <= counter + 1;
  end

  assign count = counter;

endmodule