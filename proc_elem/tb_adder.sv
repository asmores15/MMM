/// Anastasia Frattarole
/// EE 497

module tb_adder;
wire [15:0] sum, p_s, m_p;
reg sign1, sign2;
reg [4:0] exp1, exp2;
reg [9:0] fra1, fra2;
integer flag = 0;

assign p_s = {sign1, exp1, fra1};
assign m_p = {sign2, exp2, fra2};

adder dut(p_s, m_p, sum);

initial
begin  
  {sign1, exp1, fra1} = {1'b0, 5'b01111, 10'b0000000000};
  {sign2, exp2, fra2} = {1'b0, 5'b10001, 10'b0100000000};
  #100 
  if (sum !== 16'h4600)
  begin
    $display("result 1 is wrong");
	 flag = flag + 1;
  end
  
  {sign1, exp1, fra1} = {1'b0, 5'b01111, 10'b0000000000};
  {sign2, exp2, fra2} = {1'b0, 5'b10011, 10'b1111000000};
  #100 
  if (sum !== 16'h5000)
  begin
    $display("result 2 is wrong");
	 flag = flag + 1;
  end
  
  {sign1, exp1, fra1} = {1'b0, 5'b10010, 10'b0100000000};
  {sign2, exp2, fra2} = {1'b0, 5'b10011, 10'b0100000000};
  #100
  if (sum !== 16'h4F80)
  begin
    $display("result 3 is wrong");
	 flag = flag + 1;
  end
  
  {sign1, exp1, fra1} = {1'b1, 5'b10101, 10'b1001000000};
  {sign2, exp2, fra2} = {1'b0, 5'b10101, 10'b1011100000};
  #100
  if (sum !== 16'h4900)
  begin
    $display("result 4 is wrong");
	 flag = flag + 1;
  end
  
  {sign1, exp1, fra1} = {1'b0, 5'b10000, 10'b0000000000};
  {sign2, exp2, fra2} = {1'b0, 5'b10001, 10'b0000000000};
  #100
  if (sum !== 16'h4600)
  begin
    $display("result 5 is wrong");
	 flag = flag + 1;
  end
  
  {sign1, exp1, fra1} = {1'b1, 5'b10000, 10'b0000000000};
  {sign2, exp2, fra2} = {1'b0, 5'b10000, 10'b0000000000};
  #100
  if (sum !== 16'h0000)
  begin
    $display("result 6 is wrong");
	 flag = flag + 1;
  end
  
  {sign1, exp1, fra1} = {1'b0, 5'b10101, 10'b1010100000};
  {sign2, exp2, fra2} = {1'b1, 5'b10011, 10'b0110000000};
  #100
  if (sum !== 16'h5540)
  begin
    $display("result 7 is wrong");
	 flag = flag + 1;
  end
  
  {sign1, exp1, fra1} = {1'b1, 5'b11001, 10'b1111101001};
  {sign2, exp2, fra2} = {1'b0, 5'b10111, 10'b1010100000};
  #100
  if (sum !== 16'hE641)
  begin
    $display("result 8 is wrong");
	 flag = flag + 1;
  end
  
  if (!flag)
    $display("hooray! it was all correct!!");
end
endmodule