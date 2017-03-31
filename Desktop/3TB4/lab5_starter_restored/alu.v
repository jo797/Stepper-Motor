module alu (input add_sub, set_low, set_high, input [7:0] operanda , operandb, output reg [7:0] result);
//assume active low
if (set_low==0)
	begin
    result <= {operanda[7:4], operandb[3:0]};
	end
else if (set_high==0)
	begin
    result <= {operandb[3:0], operanda[3:0]};
	end
  else 
    if(add_sub==0) // addition
    begin
      result <= operanda+operandb;
    end
    else
      begin
        result <= operanda-operandb;
      end
  end

endmodule
