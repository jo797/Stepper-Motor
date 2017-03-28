module immediate_extractor (input [7:0] instruction, input [1:0] select, output reg [7:0] immediate);


immediate = 8b'00000000
  always(select)
    begin 
      if(instruction[7:5]==3'b100|3'b101|3'b000|3'b001);
      begin
        immediate[3:1] = instruction[4:2];
      end
      if(instruction[7:4]==4'b0100|4'b0101|4'b0111);
	    begin
        immediate[3:1] = instruction[3:0];
      end
      if(instruction[7:2] == 6'b011000);
if (instruction[7:2]==6'b110000);
if(instruction[7:2]==6'b110001);
if(instruction[7:2]==6'b110010);

if(instruction[7:0]==8'b11111111);

end
endmodule

