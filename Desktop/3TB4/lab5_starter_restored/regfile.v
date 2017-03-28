// This module implements the register file

module regfile (input clk, reset_n, write, input [7:0] data, input [1:0] select0, select1, wr_select,
				output reg [7:0] selected0, selected1, output [7:0] delay, position, register0);

// The comment /* synthesis preserve */ after the declaration of a register
// prevents Quartus from optimizing it, so that it can be observed in simulation
// It is important that the comment appear before the semicolon
reg [7:0] reg0 /* synthesis preserve */;
reg [7:0] reg1 /* synthesis preserve */;
reg [7:0] reg2 /* synthesis preserve */; //stores position of stepper motor
reg [7:0] reg3 /* synthesis preserve */; //delay value, in 0.01s


always @(posedge clk)
begin
	if (reset_n==0)
	begin
		reg2 = 8'b0;
	end
	/* CW  half stepper
	elseif ()
	begin
		reg2 = reg2 + 8'b00000001;
	end
	*/
	/*CW  full stepper
	elseif()
	begin
		reg2 = reg2 + 8'b00000002;
	end
	*/
	
	/* CCW  half stepper
	elseif ()
	begin
		reg2 = reg2 - 8'b00000001;
	end
	*/
	/*CCW  full stepper
	elseif()
	begin
		reg2 = reg2 - 8'b00000002;
	end
	*/
end

assign reg0 =  register0;
assign reg2 =  position;
assign reg3 =  delay;

endmodule
