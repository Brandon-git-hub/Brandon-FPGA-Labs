module HDLBits_Test (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);
    reg [31:0] pre;
    wire [31:0] falling_edge = pre & ~in;
    always @ (posedge clk) begin
        if (reset) begin
            out <= 32'd0;
            pre <= 32'd0;
        end
        else begin
        	out <= (out | falling_edge);
        end
        pre <= in;
    end

endmodule