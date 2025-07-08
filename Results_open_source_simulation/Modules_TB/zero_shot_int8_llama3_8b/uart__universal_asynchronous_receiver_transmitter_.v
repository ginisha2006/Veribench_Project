uart_tb; 

parameter BAUD_RATE = 9600; 
reg clk; 
reg rst; 
wire tx; 
wire [7:0] data_out; 
integer i; 

initial begin 
    clk = 1'b0; 
    rst = 1'b1; 
    #10 rst = 1'b0; 
    #10000000; 
    rst = 1'b1; 
    #10; 
    forever begin 
        clk = ~clk; 
        #5; 
    end 
end 

always @(posedge clk) begin 
    if (rst) begin 
        tx <= 1'bx; 
        data_out <= 8'bz; 
    end else begin 
        // Test RX functionality 
        for (i = 0; i < 8; i = i + 1) begin 
            #((BAUD_RATE / 2) * 10 - 1); 
            rx <= 1'b1; 
            #((BAUD_RATE / 2) * 10 - 1); 
            rx <= 1'b0; 
        end 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b1; 
        #((BAUD_RATE / 2) * 10); 
        rx <= 1'b0; 
        #((BAUD_RATE / 2) * 10); 
        rx