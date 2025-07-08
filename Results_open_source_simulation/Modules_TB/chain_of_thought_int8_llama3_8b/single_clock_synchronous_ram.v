module tb_ram_infer;

reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we;
wire [7:0] q;

initial begin
    #100; // wait for 100 time units
    data = 8'h12; // set initial data value
    write_addr = 6'b000010; // set initial write address
    we = 1; // set write enable high
    #10; // wait for 10 time units
    we = 0; // reset write enable low
    
    #100; // wait for 100 time units
    read_addr = 6'b000011; // set read address
    #10; // wait for 10 time units
    
    #100; // wait for 100 time units
    data = 8'h34; // change data value
    write_addr = 6'b000100; // change write address
    we = 1; // set write enable high
    #10; // wait for 10 time units
    we = 0; // reset write enable low
    
    #100; // wait for 100 time units
    read_addr = 6'b000101; // set read address
    #10; // wait for 10 time units
end

always @(posedge clk) begin
    $monitor($time, "data: %h, write_addr: %b, read_addr: %b, q: %h", data, write_addr, read_addr, q);
end

reg clk;
initial begin
    clk = 0;
    forever #(5) clk = ~clk; // generate clock signal with period 10 time units
end

endmodule