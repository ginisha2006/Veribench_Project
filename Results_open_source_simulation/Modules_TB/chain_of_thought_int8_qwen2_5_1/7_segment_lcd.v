module tb_seven_seg_display;

reg [3:0] data_in;
wire [6:0] seg_out;

seven_seg_display uut (
    .data(data_in),
    .seg(seg_out)
);

initial begin
    $dumpfile("tb_seven_seg_display.vcd");
    $dumpvars(0, tb_seven_seg_display);
    
    data_in = 4'h0; #10
    data_in = 4'h1; #10
    data_in = 4'h2; #10
    data_in = 4'h3; #10
    data_in = 4'h4; #10
    data_in = 4'h5; #10
    data_in = 4'h6; #10
    data_in = 4'h7; #10
    data_in = 4'h8; #10
    data_in = 4'h9; #10
    data_in = 4'hA; #10
    data_in = 4'hB; #10
    data_in = 4'hC; #10
    data_in = 4'hD; #10
    data_in = 4'hE; #10
    data_in = 4'hF; #10
    data_in = 4'ha; #10
    
    $finish;
end

always @(posedge data_in) 
begin
    $monitor($time," ns Data In = %b Seg Out = %b", data_in, seg_out);
end

endmodule