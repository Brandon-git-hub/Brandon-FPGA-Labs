module top_module(input CLOCK_50, output [7:0] LED);
	
	// CLK Divider
	localparam CLK_DIV = 24; // 2^24 = 16M
	reg [CLK_DIV-1 : 0] CLK_DIV_reg = {CLK_DIV{1'b0}};
	
	always @(posedge CLOCK_50) begin
		CLK_DIV_reg <= CLK_DIV_reg + 1'b1;
	end
	
	wire clk_1hz =  CLK_DIV_reg[CLK_DIV-1];
	
	// detect rising
	reg clk_1hz_d;
	always @ (posedge CLOCK_50) begin
		clk_1hz_d <= clk_1hz;
	end
	wire tick_1hz = clk_1hz & ~clk_1hz_d;
	
	// LED Counter
	reg [7:0] led_counter = 8'h00;
	always @ (posedge CLOCK_50) begin
		if (tick_1hz) begin
			led_counter <= led_counter + 1'b1;
		end
	end
	assign LED = led_counter;

endmodule