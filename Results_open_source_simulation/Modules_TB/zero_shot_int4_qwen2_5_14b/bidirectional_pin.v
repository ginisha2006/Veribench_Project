module tb_bidir_pin;
    reg dir;
    reg [20:0] data_out;
    wire [20:0] data_in;
    wire [20:0] pin;
    
    bidir_pin #(.WIDTH(21)) uut (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );
    
    initial begin
        // Initialize signals
        dir = 0;
        data_out = 21'b0;
        
        // Monitor inputs and outputs
        $monitor($time, " ns: dir=%b, data_out=%b, data_in=%b", dir, data_out, data_in);
        
        // Test vectors
        @(posedge $rose(dir));
        data_out = 21'b101010101010101010101;
        @(negedge dir);
        data_out = 21'b111111111111111111111;
        @(posedge dir);
        data_out = 21'b000000000000000000000;
        @(negedge dir);
        data_out = 21'hFFFFF;
        @(posedge dir);
        data_out = 21'hABCDEF;
        @(negedge dir);
        data_out = 21'hDEADBEEF;
        @(posedge dir);
        data_out = 21'hCAFE;
        @(negedge dir);
        data_out = 21'hBADA55;
        @(posedge dir);
        data_out = 21'hF00D;
        @(negedge dir);
        data_out = 21'hDEAD;
        @(posedge dir);
        data_out = 21'hBEEF;
        @(negedge dir);
        data_out = 21'hCAFEBABE;
        @(posedge dir);
        data_out = 21'hBADFACE;
        @(negedge dir);
        data_out = 21'hDEADC0DE;
        @(posedge dir);
        data_out = 21'hBEAF;
        @(negedge dir);
        data_out = 21'hC0FFEE;
        @(posedge dir);
        data_out = 21'hDEADBEEFCAFE;
        @(negedge dir);
        data_out = 21'hBADA55DEADBEEF;
        @(posedge dir);
        data_out = 21'hCAFEBABEDECAF;
        @(negedge dir);
        data_out = 21'hDEADBEEFC0FFEE;
        @(posedge dir);
        data_out = 21'hBADFACEBABE;
        @(negedge dir);
        data_out = 21'hCAFEBABEDECACAFE;
        @(posedge dir);
        data_out = 21'hDEADBEEFBADFACE;
        @(negedge dir);
        data_out = 21'hCAFEBABEDECACAFEBADFACE;
        @(posedge dir);
        data_out = 21'hDEADBEEFC0FFEECAFEBABEDECACAFE;
        @(negedge dir);
        data_out = 21'hBADFACEBABEDECACAFEBADFACE;
        @(posedge dir);
        data_out = 21'hCAFEBABEDECACAFEBADFACECAFEBABEDECACAFE;
        @(negedge dir);
        data_out = 21'hDEADBEEFC0FFEECAFEBABEDECACAFEBADFACECAFEBABEDECACAFE;
        @(posedge dir);
        data_out = 21'hBADFACEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACE;
        @(negedge dir);
        data_out = 21'hCAFEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACE;
        @(posedge dir);
        data_out = 21'hDEADBEEFC0FFEECAFEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACE;
        @(negedge dir);
        data_out = 21'hBADFACEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACE;
        @(posedge dir);
        data_out = 21'hCAFEBABEDECACAFEBADFACECAFEBABEDECACAFEBADFACECAFEB