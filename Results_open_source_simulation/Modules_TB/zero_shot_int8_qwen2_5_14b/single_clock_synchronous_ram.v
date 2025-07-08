module tb_ram_infer;

	reg clk;
	reg we;
	wire [7:0] q;
	reg [7:0] data;
	reg [5:0] read_addr, write_addr;

	ram_infer dut (
		.data(data),
		.read_addr(read_addr),
		.write_addr(write_addr),
		.we(we),
		.clk(clk),
		.q(q)
	);
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk; // 20ns period clock
	end
	
	initial begin
		data = 8'b0;
		read_addr = 6'b0;
		write_addr = 6'b0;
		we = 0;
		
		#10 we = 1;
		data = 8'hAA;
		write_addr = 6'h0F;
		#10 we = 0;
		read_addr = 6'h0F;
		#10 read_addr = 6'hFF;
		#10 read_addr = 6'h0F;
		#10 read_addr = 6'h00;
		#10 read_addr = 6'hFE;
		#10 read_addr = 6'h0A;
		#10 read_addr = 6'h0B;
		#10 read_addr = 6'h0C;
		#10 read_addr = 6'h0D;
		#10 read_addr = 6'h0E;
		#10 read_addr = 6'h0F;
		#10 $stop;
	end
	
	initial begin
		$monitor($time," ns: Data = %h, Read Addr = %b, Write Addr = %b, We = %b, Q = %h",data,read_addr,write_addr,we,q);
	end
	
endmodule