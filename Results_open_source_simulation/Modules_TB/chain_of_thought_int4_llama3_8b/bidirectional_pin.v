bidir_pin_tb; 

parameter WIDTH = 1; 

reg dir; 
reg [WIDTH-1:0] data_out; 
wire [WIDTH-1:0] data_in; 
wire [WIDTH-1:0] pin; 

initial begin 
    dir = 0; 
    data_out = 8'h12; 
    #10; 
    dir = 1; 
    data_out = 8'h34; 
    #20; 
    dir = 0; 
    data_out = 8'h56; 
    #30; 
    dir = 1; 
    data_out = 8'h78; 
    #40; 
    dir = 0; 
    data_out = 8'h90; 
    #50; 
    dir = 1; 
    data_out = 8'hAB; 
    #60; 
    dir = 0; 
    data_out = 8'hCD; 
    #70; 
    dir = 1; 
    data_out = 8'hEF; 
    #80; 
    dir = 0; 
    data_out = 8'h01; 
    #90; 
    dir = 1; 
    data_out = 8'h23; 
    #100; 
    dir = 0; 
    data_out = 8'h45; 
    #110; 
    dir = 1; 
    data_out = 8'h67; 
    #120; 
    dir = 0; 
    data_out = 8'h89; 
    #130; 
    dir = 1; 
    data_out = 8'hB2; 
    #140; 
    dir = 0; 
    data_out = 8'hC4; 
    #150; 
    dir = 1; 
    data_out = 8'hE6; 
    #160; 
    dir = 0; 
    data_out = 8'h08; 
    #170; 
    dir = 1; 
    data_out = 8'h29; 
    #180; 
    dir = 0; 
    data_out = 8'h4A; 
    #190; 
    dir = 1; 
    data_out = 8'h5B; 
    #200; 
    dir = 0; 
    data_out = 8'h7C; 
    #210; 
    dir = 1; 
    data_out = 8'h9D; 
    #220; 
    dir = 0; 
    data_out = 8'hBE; 
    #230; 
    dir = 1; 
    data_out = 8'hCF; 
    #240; 
    dir = 0; 
    data_out = 8'hD0; 
    #250; 
    dir = 1; 
    data_out = 8'hF1; 
    #260; 
    dir = 0; 
    data_out = 8'h02; 
    #270; 
    dir = 1; 
    data_out = 8'h13; 
    #280; 
    dir = 0; 
    data_out = 8'h24; 
    #290; 
    dir = 1; 
    data_out = 8'h35; 
    #300; 
    dir = 0; 
    data_out = 8'h46; 
    #310; 
    dir = 1; 
    data_out = 8'h57; 
    #320; 
    dir = 0; 
    data_out = 8'h68; 
    #330; 
    dir = 1; 
    data_out = 8'h79; 
    #340; 
    dir = 0; 
    data_out = 8'h8A; 
    #350; 
    dir = 1; 
    data_out = 8'h9B; 
    #360; 
    dir = 0; 
    data_out = 8'hAC; 
    #370; 
    dir = 1; 
    data_out = 8'hBD; 
    #380; 
    dir = 0; 
    data_out = 8'hCE; 
    #390; 
    dir = 1; 
    data_out = 8'hDF; 
    #400; 
    dir = 0; 
    data_out = 8'hE0; 
    #410; 
    dir = 1; 
    data_out = 8'hF2; 
    #420; 
    dir = 0; 
    data_out = 8'h03; 
    #430; 
    dir = 1; 
    data