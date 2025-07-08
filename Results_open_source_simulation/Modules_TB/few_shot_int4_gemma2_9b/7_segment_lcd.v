module tb_seven_seg_display;
  reg [3:0] data;
  wire [6:0] seg;
  seven_seg_display #( .DATA_WIDTH(4) ) uut (
    .data(data),
    .seg(seg)
  );
  initial begin
    $display("Time	Data	Seg");
    $monitor("%0d	%b	%b", $time, data, seg);
    data = 4'h0; #10;
    data = 4'h1; #10;
    data = 4'h2; #10;
    data = 4'h3; #10;
    data = 4'h4; #10;
    data = 4'h5; #10;
    data = 4'h6; #10;
    data = 4'h7; #10;
    data = 4'h8; #10;
    data = 4'h9; #10;
    data = 4'hA; #10;
    data = 4'hB; #10;
    data = 4'hC; #10;
    data = 4'hD; #10;
    data = 4'hE; #10;
    data = 4'hF; #10;
    $finish;
  end
endmodule