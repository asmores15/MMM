/// Anastasia Frattarole
/// EE 497

module tb_multiplier();
wire [15:0] sum, w, m;
reg sign1, sign2;
reg [4:0] exp1, exp2;
reg [9:0] fra1, fra2;

assign w = {sign1, exp1, fra1};
assign m = {sign2, exp2, fra2};

multiplier dut(w, m, sum);

initial
begin  
  {sign1, exp1, fra1} = {1'b0, 5'b01111, 10'b0000000000};    // 1
  {sign2, exp2, fra2} = {1'b0, 5'b10001, 10'b0100000000};    // 5
  #100 
  $display("expected product: 0100010100000000");  // 5
  if (sum !== 16'h4500)
    $display("product 1 is wrong");
  else
    $display("product 1 is correct!");
  
  {sign1, exp1, fra1} = {1'b0, 5'b01111, 10'b0000000000};    // 1
  {sign2, exp2, fra2} = {1'b0, 5'b10011, 10'b1111000000};    // 31
  #100 
  $display("expected product: 0100111111000000");  // 31
  if (sum !== 16'h4FC0)
    $display("product 2 is wrong");
  else
    $display("product 2 is correct!");
  
  {sign1, exp1, fra1} = {1'b0, 5'b10010, 10'b0100000000};    // 10
  {sign2, exp2, fra2} = {1'b0, 5'b10011, 10'b0100000000};    // 20
  #100
  $display("expected product: 0101101001000000");  // 200
  if (sum !== 16'h5A40)
    $display("product 3 is wrong");
  else
    $display("product 3 is correct!");
  
  {sign1, exp1, fra1} = {1'b1, 5'b10101, 10'b1001000000};    // -100
  {sign2, exp2, fra2} = {1'b0, 5'b10101, 10'b1011100000};    // 110
  #100
  $display("expected product: 1111000101011111");  // 
  if (sum !== 16'hF15F)
    $display("product 4 is wrong");
  else
    $display("product 4 is correct!");
  
  {sign1, exp1, fra1} = {1'b0, 5'b10000, 10'b0000000000};    // 2
  {sign2, exp2, fra2} = {1'b0, 5'b10001, 10'b0000000000};    // 4
  #100
  $display("expected product: 0100100000000000");  // 8
  if (sum !== 16'h4800)
    $display("product 5 is wrong");
  else
    $display("product 5 is correct!");
	
  {sign1, exp1, fra1} = {1'b0, 5'b10011, 10'b0110100000};    // 22.5
  {sign2, exp2, fra2} = {1'b0, 5'b10010, 10'b1000100110};    // 12.3
  #100
  $display("expected product: 0101110001010011");  // 276.75
  if (sum !== 16'h5C53)
    $display("product 6 is wrong");
  else
    $display("product 6 is correct!");
	
  {sign1, exp1, fra1} = {1'b1, 5'b10001, 10'b0000100110};    // -4.15
  {sign2, exp2, fra2} = {1'b0, 5'b10001, 10'b1010010111};    // 6.59
  #100
  $display("expected product: 1100111011010110");  // 27.34375
  if (sum !== 16'hCED6)
    $display("product 7 is wrong");
  else
    $display("product 7 is correct!");
	
  {sign1, exp1, fra1} = {1'b1, 5'b10010, 10'b0001001111};    // -8.62
  {sign2, exp2, fra2} = {1'b1, 5'b10001, 10'b1100000000};    // -7
  #100
  $display("expected product: 0101001110001010");  // 60.3125
  if (sum !== 16'h538A)
    $display("product 8 is wrong");
  else
    $display("product 8 is correct!");
  
  //$display("hooray! it was all correct!!");
end
endmodule