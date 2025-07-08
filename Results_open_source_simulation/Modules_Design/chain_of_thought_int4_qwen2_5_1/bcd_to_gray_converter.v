module bcd_to_gray #(
    parameter int BCD_WIDTH = 4,
    parameter int GRAY_WIDTH = 4
)(
    input logic [BCD_WIDTH-1:0] bcd,
    output logic [GRAY_WIDTH-1:0] gray
);
    
    always_comb begin
        gray[0] = bcd[0];
        for (int i = 1; i < GRAY_WIDTH; i++) 
            gray[i] = bcd[i] ^ bcd[i-1];
    end
    
endmodule