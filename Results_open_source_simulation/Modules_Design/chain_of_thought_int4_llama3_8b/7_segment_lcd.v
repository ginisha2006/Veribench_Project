module seven_seg_display #(parameter DATA_WIDTH = 4)(input [DATA_WIDTH-1:0] data, output reg [6:0] seg);

always @(posedge clock) // Assuming a clock signal is present in the system

begin

case(data)

default: seg = 7'b0000000; // Default state when no input is provided

7'h0: seg = 7'b1111110; // Segment mapping for '0'

7'h1: seg = 7'b0110000;

7'h2: seg = 7'b1101001;

7'h3: seg = 7'b1010011;

7'h4: seg = 7'b1000111;

7'h5: seg = 7'b1111001;

7'h6: seg = 7'b1001110;

7'h7: seg = 7'b1000110;

7'h8: seg = 7'b1110000;

7'h9: seg = 7'b1100011;

7'ha: seg = 7'b1001001;

7'hB: seg = 7'b1000111;

7'hC: seg = 7'b1100100;

7'hD: seg = 7'b1001100;

7'hE: seg = 7'b1001111;

7'hF: seg = 7'b10010011;

endcase

end

endmodule