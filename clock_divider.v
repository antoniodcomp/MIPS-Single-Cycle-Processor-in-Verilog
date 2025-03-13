module clock_divider(
    input clk,
    input reset,
    output reg slow_clk
);
    reg [31:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            slow_clk <= 0;
        end else begin
            if (count == 5000000) begin // Ajuste para 1 Hz (50 MHz / 10^7)
                count <= 0;
                slow_clk <= ~slow_clk;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule