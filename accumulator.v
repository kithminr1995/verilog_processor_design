//Accumulator(AC) is a register in which intermediate arithmetic and logic results are stored

module accumulator( 	input wire [15:0] data_in, 
							input wire clk_50m, 	
							input wire wr_en,
							input wire reset,
							output reg [15:0] acc_out
						);
always @(posedge clk_50m)
		begin
		if (reset == 1)
			acc_out <= 16'd0;
		else
			if (wr_en == 1)
				acc_out <= data_in;
		end
end module

