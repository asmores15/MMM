module tb_systolic_array();

wire [15:0] down1, down2;
wire [15:0] top1, top2, left1, left2;
reg clk, reset, we1, we2, we3, we4, mux1, mux2, mux3, mux4;
reg sign1, sign2, sign3, sign4;
reg [4:0] exp1, exp2, exp3, exp4;
reg [9:0] fra1, fra2, fra3, fra4;

assign top1 = {sign1, exp1, fra1};
assign top2 = {sign2, exp2, fra2};
assign left1 = {sign3, exp3, fra3};
assign left2 = {sign4, exp4, fra4};

systolic_array dut(clk, reset, top1, top2, left1, left2, we1, we2, we3, we4, mux1, mux2, mux3, mux4, down1, down2);

initial
begin
// load weights into PEs
reset <= 0;
we1 = 1;
we2 = 0;
we3 = 1;
we4 = 0;
{sign1, exp1, fra1} = {1'b0, 5'b10001, 10'b0100000000};    // 5
{sign2, exp2, fra2} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign3, exp3, fra3} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign4, exp4, fra4} = {1'b0, 5'b00000, 10'b0000000000};    // 0
mux1 = 0;
mux2 = 0;
mux3 = 0;
mux4 = 0; 

#20;
we1 = 0;
we2 = 1;
we3 = 0;
we4 = 1;
{sign1, exp1, fra1} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign2, exp2, fra2} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign3, exp3, fra3} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign4, exp4, fra4} = {1'b0, 5'b00000, 10'b0000000000};    // 0
mux1 = 0;
mux2 = 0;
mux3 = 0;
mux4 = 0;

// proceed with calculations
#20;
we1 = 0;
we2 = 0;
we3 = 0;
we4 = 0;
{sign1, exp1, fra1} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign2, exp2, fra2} = {1'b0, 5'b10000, 10'b0000000000};    // 0
{sign3, exp3, fra3} = {1'b0, 5'b10001, 10'b0000000000};    // 4
{sign4, exp4, fra4} = {1'b0, 5'b10000, 10'b0000000000};    // 2
mux1 = 1;
mux2 = 1;
mux3 = 1;
mux4 = 1;

#20;
we1 = 0;
we2 = 0;
we3 = 0;
we4 = 0;
{sign1, exp1, fra1} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign2, exp2, fra2} = {1'b0, 5'b10000, 10'b0000000000};    // 0
{sign3, exp3, fra3} = {1'b1, 5'b10101, 10'b1001000000};    // -100
{sign4, exp4, fra4} = {1'b0, 5'b10101, 10'b1011100000};    // 110
mux1 = 1;
mux2 = 1;
mux3 = 1;
mux4 = 1;

#20;
we1 = 0;
we2 = 0;
we3 = 0;
we4 = 0;
{sign1, exp1, fra1} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign2, exp2, fra2} = {1'b0, 5'b10000, 10'b0000000000};    // 0
{sign3, exp3, fra3} = {1'b1, 5'b10001, 10'b0000100110};    // -4.15
{sign4, exp4, fra4} = {1'b0, 5'b10001, 10'b1010010111};    // 6.59
mux1 = 1;
mux2 = 1;
mux3 = 1;
mux4 = 1;

#20;
we1 = 0;
we2 = 0;
we3 = 0;
we4 = 0;
{sign1, exp1, fra1} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign2, exp2, fra2} = {1'b0, 5'b10000, 10'b0000000000};    // 0
{sign3, exp3, fra3} = {1'b1, 5'b10010, 10'b0001001111};    // -8.62
{sign4, exp4, fra4} = {1'b1, 5'b10001, 10'b1100000000};    // -7
mux1 = 1;
mux2 = 1;
mux3 = 1;
mux4 = 1;

#20;
we1 = 0;
we2 = 0;
we3 = 0;
we4 = 0;
{sign1, exp1, fra1} = {1'b0, 5'b00000, 10'b0000000000};    // 0
{sign2, exp2, fra2} = {1'b0, 5'b10000, 10'b0000000000};    // 0
{sign3, exp3, fra3} = {1'b0, 5'b10010, 10'b1110011101};    // 15.23
{sign4, exp4, fra4} = {1'b0, 5'b10001, 10'b0101100110};    // 5.40
mux1 = 1;
mux2 = 1;
mux3 = 1;
mux4 = 1;
end
					  
always
begin
clk <= 1;
 #10; 
 clk <= 0;
 #10; 
end

endmodule