module temp_register (input clk, reset_n, load, increment, decrement, input [7:0] data,
					output negative, positive, zero);

	
reg [7:0] counter=0;
always @(*)
begin
	if (load)
	begin
		//number of steps/HS that need to happen
		counter<= data;
	end
	if (increment)
	begin
		counter<= counter++;
	end
	if (decrement)
	begin
		counter<= counter--;
	end
	if(counter <0)
		negative = 1;
		zero=0;
		positive=0;
	else if (counter == 0)
		zero=1;
		negative =0;
		positive = 0;
	else
		positive=1;
		negative = 0;
		zero= 0;
end

endmodule
