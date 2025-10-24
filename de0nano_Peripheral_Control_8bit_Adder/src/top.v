module top_module(input CLOCK_50, input [1:0] KEY, input [3:0] SW, output reg [7:0] LED);

	wire reset_n;
	wire start_n;
	wire [1:0] sum;
	wire [1:0] cout;
	assign reset_n = KEY[0];
	assign start_n   = KEY[1]; 
	
	Fadd add0(.a(SW[2]), .b(SW[0]), .cin(1'b0), .cout(cout[0]), .sum(sum[0]));
	Fadd add1(.a(SW[3]), .b(SW[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum[1]));
	
	reg start_n_dff1, start_n_dff0;
	always @ (posedge CLOCK_50 or negedge reset_n) begin
		if (!reset_n) begin
			{start_n_dff1, start_n_dff0} <= 2'b11;
		end
		else begin
			{start_n_dff1, start_n_dff0} <= {start_n_dff0, start_n};
		end
	end
	wire start = start_n_dff1 & ~start_n_dff0;
		
	always @ (posedge CLOCK_50 or negedge reset_n) begin
		if (!reset_n) begin
			LED <= 8'h00;
		end
		else begin
			if (start) begin
				LED <= {5'b0, cout[1], sum[1:0]};
			end
		end
	end

endmodule