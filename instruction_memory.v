module instruction_memory(clk, reset, read_address, instruction_out);
    input clk, reset;
    input [31:0] read_address;
    integer i;
    integer k;
    output [31:0] instruction_out;

    reg [31:0] I_MEM [63:0];

    assign instruction_out = I_MEM[read_address];

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            begin
                for(k = 0; k < 64; k=k+1)begin
                    I_MEM[k] <= 32'b00;
                end
            end
        end

       else begin

           I_MEM[4]  = 32'b000000_10011_10011_01001_00000_100000; //add $t1, $s3, $s3
           I_MEM[8]  = 32'b000000_01001_01001_01001_00000_100000; //add $t1, $t1, $t1
           I_MEM[12] = 32'b000000_01001_10110_01001_00000_100000; //add $t1, $t1, $s6 
           I_MEM[16] = 32'b100011_01001_01000_0000000000000000; // lw $t0, 0($t1)
           I_MEM[20] = 32'b000101_01000_10101_0000000000000100; //bne $t0, $s5, Exit
           I_MEM[24] = 32'b001000_10011_10011_0000000000000001; //addi $s3, $s3, 1
           I_MEM[28] = 32'b000010_00000000000000000000000001; //j 4


        end
    end 

endmodule