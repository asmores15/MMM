/// Anastasia Frattarole
/// EE 497


module tb_proc_elem();

wire [15:0] down, right;
wire [15:0] top, left;
reg clk, reset, we, mux;
reg sign1, sign2;
reg [4:0] exp1, exp2;
reg [9:0] fra1, fra2;

assign top = {sign1, exp1, fra1};
assign left = {sign2, exp2, fra2};

proc_elem dut(down, right, top, left, we, mux, clk, reset);

initial
begin
//reset <= 1; # 10; 
reset <= 0;
we = 1;
{sign1, exp1, fra1} = {1'b0, 5'b10001, 10'b0100000000};     // 5
{sign2, exp2, fra2} = {1'b0, 5'b00000, 10'b0000000000};     // 0
mux = 0; 
#10;
we = 0;
{sign1, exp1, fra1} = {1'b0, 5'b10001, 10'b0100000000};    // 5
{sign2, exp2, fra2} = {1'b0, 5'b10000, 10'b0000000000};    // 2
mux = 0; 
#10;
we = 0;
{sign1, exp1, fra1} = {1'b0, 5'b10001, 10'b0000000000};    // 4
{sign2, exp2, fra2} = {1'b0, 5'b10000, 10'b0000000000};    // 2
mux = 1; 
#10;
we = 0;
{sign1, exp1, fra1} = {1'b1, 5'b10101, 10'b1001000000};    // -100
{sign2, exp2, fra2} = {1'b0, 5'b10101, 10'b1011100000};    // 110
mux = 1; 
#10;
we = 0;
{sign1, exp1, fra1} = {1'b1, 5'b10001, 10'b0000100110};    // -4.15
{sign2, exp2, fra2} = {1'b0, 5'b10001, 10'b1010010111};    // 6.59
mux = 1;
#10;
we = 0;
{sign1, exp1, fra1} = {1'b1, 5'b10010, 10'b0001001111};    // -8.62
{sign2, exp2, fra2} = {1'b1, 5'b10001, 10'b1100000000};    // -7
mux = 1;
end
					  
always
begin
clk <= 1;
 # 5; 
 clk <= 0;
 # 5; // clock duration
end

endmodule