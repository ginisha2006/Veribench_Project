module tb_ram_dual;

reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we;
reg read_clock, write_clock;
wire [7:0] q;

ram_dual dut (
	.data(data),
	.read_addr(read_addr),
	.write_addr(write_addr),
	.we(we),
	.read_clock(read_clock),
	.write_clock(write_clock),
	.q(q)
);

initial begin
    #100; // wait for initial clock cycle
    write_clock = 0; read_clock = 0;
    we = 0;
    data = 8'h12;
    write_addr = 6'b000010;
    read_addr = 6'b000011;
    #10;
    write_clock = 1; we = 1;
    #20;
    write_clock = 0;
    #10;
    read_clock = 1;
    #10;
    read_clock = 0;
    #10;
    write_clock = 1; we = 1;
    data = 8'h34;
    write_addr = 6'b000101;
    #20;
    write_clock = 0;
    #10;
    read_clock = 1;
    read_addr = 6'b000101;
    #10;
    read_clock = 0;
    #100;
    $monitor($time, "data=%b, read_addr=%b, write_addr=%b, we=%b, read_clock=%b, write_clock=%b, q=%b", 
             data, read_addr, write_addr, we, read_clock, write_clock, q);
end

always #10 read_clock = ~read_clock;
always #10 write_clock = ~write_clock;

endmodule