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
    #10;
    dir = 0;
    data_out = 8'h34;
    #10;
    dir = 1;
    #10;
    dir = 0;
    data_out = 8'h56;
    #10;
    dir = 1;
    #20;
    dir = 0;
    data_out = 8'h78;
    #10;
    dir = 1;
    #20;
    dir = 0;
    data_out = 8'h90;
    #100;
    $display("Test completed");
end

always @(posedge clk) begin 
    if(dir == 1) begin 
        $monitor($time,"dir=1, pin=%b, data_in=%h",pin,data_in);
    end else begin 
        $monitor($time,"dir=0, pin=%b, data_in=%h",pin,data_in);
    end
end

always @(negedge clk) begin 
    if(dir == 1) begin 
        $display($time,"dir=1, pin=%b, data_in=%h",pin,data_in);
    end else begin 
        $display($time,"dir=0, pin=%b, data_in=%h",pin,data_in);
    end
end

default_nettype none;