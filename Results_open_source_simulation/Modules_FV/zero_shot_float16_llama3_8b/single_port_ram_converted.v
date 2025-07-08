module tb_single_port_ram;

// Input/Output signals declaration
logic [7:0] data_in;
logic [5:0] addr_in;
logic we;
logic clk;
logic [7:0] q_out;

// DUT instantiation
single_port_ram dut (
   .data(data_in),
   .addr(addr_in),
   .we(we),
   .clk(clk),
   .q(q_out)
);

// Clock generation
always #10 clk = ~clk; // Non-deterministic clock with 50% duty cycle

// Property 1: Data written when write enable is high
// Property 2: Data read correctly when write enable is low
// Property 3: Overflow check
// Property 4: Underflow check
// Assert properties
always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(we) => $distinct(data_in, 8'bxxxx_xxxx))); end
always @(*) begin assert (@(posedge clk) disable iff (we) ($fell(clk) => $distinct(q_out, 8'bxxxx_xxxx))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(we) && addr_in > 6'd62 => $error("Overflow detected"))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(we) && addr_in < 6'd0 => $error("Underflow detected"))); end

endmodule