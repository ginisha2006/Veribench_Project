module bcd_to_gray(BCD_WIDTH, GRAY_WIDTH); 
parameter BCD_WIDTH = 4; 
parameter GRAY_WIDTH = 4; 
input [BCD_WIDTH-1:0] bcd; 
output reg [GRAY_WIDTH-1:0] gray; 

always @* begin 
gray = 0; 
case ({bcd[3], bcd[2], bcd[1], bcd[0]}) 
bcdd'bx"0": gray = 4'b0000; 
bcdd'bx"1": gray = 4'b0001; 
bcdd'bx"2": gray = 4'b0011; 
bcdd'bx"3": gray = 4'b0010; 
bcdd'bx"4": gray = 4'b0111; 
bcdd'bx"5": gray = 4'b0101; 
bcdd'bx"6": gray = 4'b0110; 
bcdd'bx"7": gray = 4'b0100; 
bcdd'bx"8": gray = 4'b1001; 
bcdd'bx"9": gray = 4'b1101; 
bcdd'bx"A": gray = 4'b1011; 
bcdd'bx"B": gray = 4'b1110; 
bcdd'bx"C": gray = 4'b1000; 
bcdd'bx"D": gray = 4'b1100; 
bcdd'bx"E": gray = 4'b1111; 
bcdd'bx"F": gray = 4'b10000; 
endcase 
endmodule