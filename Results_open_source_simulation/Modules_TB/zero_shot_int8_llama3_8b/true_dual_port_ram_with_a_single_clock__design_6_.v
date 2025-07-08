module true_dpram_sclk_tb;

reg clk;
reg [7:0] data_a, data_b;
wire [5:0] addr_a, addr_b;
wire we_a, we_b;
wire [7:0] q_a, q_b;

initial begin
	#10 clk = 0; // Initialize clock low
	forever #5 clk = ~clk; // Toggle clock at 100MHz

	data_a = 8'h12; data_b = 8'h34;
	addr_a = 6'b000010; addr_b = 6'b001011;
	we_a = 1; we_b = 0;
	@(posedge clk); // Wait for clock cycle
	$monitor($time, "t= %0t, clk= %b, data_a= %h, addr_a= %b, we_a= %b, q_a= %h", clk, data_a, addr_a, we_a, q_a);

	data_a = 8'h56; data_b = 8'h78;
	addr_a = 6'b101010; addr_b = 6'b110000;
	we_a = 0; we_b = 1;
	@(posedge clk); // Wait for clock cycle
	$monitor($time, "t= %0t, clk= %b, data_b= %h, addr_b= %b, we_b= %b, q_b= %h", clk, data_b, addr_b, we_b, q_b);

	data_a = 8'h90; data_b = 8'haa;
	addr_a = 6'b111111; addr_b = 6'b000000;
	we_a = 1; we_b = 0;
	@(posedge clk); // Wait for clock cycle
	$monitor($time, "t= %0t, clk= %b, data_a= %h, addr_a= %b, we_a= %b, q_a= %h", clk, data_a, addr_a, we_a, q_a);

	data_a = 8'hbb; data_b = 8'hcc;
	addr_a = 6'b010101; addr_b = 6'b011011;
	we_a = 0; we_b = 1;
	@(posedge clk); // Wait for clock cycle
	$monitor($time, "t= %0t, clk= %b, data_b= %h, addr_b= %b, we_b= %b, q_b= %h", clk, data_b, addr_b, we_b, q_b);

	#100 $finish; // Run for 100 clock cycles and then finish
end

assign clk = 1'b0;
assign data_a = 8'x00;
assign data_b = 8'x00;
assign addr_a = 6'bx;
assign addr_b = 6'bx;
assign we_a = 1'b0;
assign we_b = 1'b0;
assign q_a = 8'x00;
assign q_b = 8'x00;

endmodule