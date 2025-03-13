module data_selector(
    input [31:0] PC,
    input [31:0] reg0, reg1, reg2, reg3, // Exemplo de registradores
    input [2:0] select,                  // Seleção via chaves (SW)
    output reg [31:0] data_out
);
    always @(*) begin
        case (select)
            3'b000: data_out = PC;      // Exibe o PC
            3'b001: data_out = reg0;    // Exibe o registrador 0
            3'b010: data_out = reg1;    // Exibe o registrador 1
            3'b011: data_out = reg2;    // Exibe o registrador 2
            3'b100: data_out = reg3;    // Exibe o registrador 3
            default: data_out = 32'd0;  // Valor padrão
        endcase
    end
endmodule

module Display4Digitos2(
    input clk,
    input reset,
    input [31:0] reg_data,
    output reg [6:0] display1, display2, display3, display4
);
    reg [3:0] ones, tens, hundreds, thousands;
    

    always @(*) begin
        ones = reg_data % 10;
        tens = (reg_data / 10) % 10;
        hundreds = (reg_data / 100) % 10;
        thousands = (reg_data / 1000) % 10;
    end

    
    function [6:0] get_segment;
        input [3:0] num;
        begin
            case (num)
                4'd0: get_segment = 7'b1000000; // Exibe 0
                4'd1: get_segment = 7'b1111001; // Exibe 1
                4'd2: get_segment = 7'b0100100; // Exibe 2
                4'd3: get_segment = 7'b0110000; // Exibe 3
                4'd4: get_segment = 7'b0011001; // Exibe 4
                4'd5: get_segment = 7'b0010010; // Exibe 5
                4'd6: get_segment = 7'b0000010; // Exibe 6
                4'd7: get_segment = 7'b1111000; // Exibe 7
                4'd8: get_segment = 7'b0000000; // Exibe 8
                4'd9: get_segment = 7'b0010000; // Exibe 9
                default: get_segment = 7'b1111111; // Apaga display
            endcase
        end
    endfunction

    
    always @(*) begin
        display1 = (reg_data >= 1000) ? get_segment(thousands) : 7'b1111111; // Milhar
        display2 = (reg_data >= 100)  ? get_segment(hundreds)  : 7'b1111111; // Centena
        display3 = (reg_data >= 10)   ? get_segment(tens)      : 7'b1111111; // Dezena
        display4 = get_segment(ones); // Unidade (sempre ativo)
    end
endmodule