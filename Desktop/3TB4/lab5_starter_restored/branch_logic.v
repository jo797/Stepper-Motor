module branch_logic (input [7:0] register0, output branch);

  if ( register0==0)
  begin
    branch <= 1 ;
  end
  else
    branch<=0;

endmodule
