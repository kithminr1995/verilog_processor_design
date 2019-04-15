// clock divider

module slowclock(	clockin,clockout);

input clockin;
output clockout;				
	
reg clockout = 1'b0;
reg counter = 1'b0;

always @ (posedge clockin)
		begin //generate rxclk 
		counter <= counter + 1'b1;
		if(counter == 1'b1)
				clockout <= ~clockout;
		end
endmodule 