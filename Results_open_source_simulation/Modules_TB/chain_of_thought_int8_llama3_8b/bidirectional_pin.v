module tb_bidir_pin;

parameter WIDTH = 4; // adjust this value according to the width specified in the module

reg [WIDTH-1:0] data_out;
wire [WIDTH-1:0] data_in;
wire [WIDTH-1:0] pin;
reg dir;

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
    #20;
    dir = 0;
    data_out = 8'h56;
    #10;
    dir = 1;
    #10;
    dir = 0;
    data_out = 8'h78;
    #100;
    $display("Simulation complete");
    $finish;
end

always @(posedge dir) begin
    $monitor($time, "dir=%b, pin=%h", dir, pin);
end

always @(posedge pin) begin
    $monitor($time, "pin=%h, data_in=%h", pin, data_in);
end

endmodule