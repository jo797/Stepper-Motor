module temp_register (input clk, reset_n, load, increment, decrement, input [7:0] data,
					output negative, positive, zero);

	
reg [31:0] counter=0;
reg [7:0] temp ;
//assume active low
always @(*)
begin
	if (load==0)
	begin
		//number of steps/HS that need to happen
		temp<= data;
	end
	if (increment==0)
	begin
		counter<= counter++;
	end
	if (decrement==0)
	begin
		counter<= counter--;
	end
	if(data <0)
		negative = 1;
	else if (data == 0)
		zero=1;
	else
		positive=1;
end

endmodule
