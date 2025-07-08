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
    #10; // delay for setup
    read_clock = 0; write_clock = 0; we = 0; // reset clocks and write enable
    data = 8'h12; write_addr = 6'b000010; // initial values
    #20; // wait for clock cycles
    write_clock = 1; we = 1; // start writing
    #10; // write cycle
    write_clock = 0; we = 0; // stop writing
    #20; // wait for clock cycles
    read_clock = 1; read_addr = 6'b000100; // start reading
    #10; // read cycle
    $monitor($time, "q:", $bits(q)); // observe output
    #100; // wait for some time
    read_clock = 0; read_addr = 6'b111110; // try out-of-range address
    #10; // read cycle
    $monitor($time, "q:", $bits(q)); // observe output
    #100; // wait for some time
    write_clock = 1; write_addr = 6'b111110; // try out-of-range address
    #10; // write cycle
    write_clock = 0; // stop writing
    #100; // wait for some time
    $finish; // end simulation
end

endmodule