/// Anastasia Frattarole
/// EE 497


module tb_reg_file();

wire [15:0] data_out;
reg [15:0] data_in;
reg we;
reg clk, reset;

reg_file dut(we, clk, reset, data_in, data_out);

initial
begin
reset <= 1; # 10; reset <= 0;
data_in = 5; we = 1;
#10;
data_in = 6; we = 0;
#10;
data_in = 7; we = 0;
#10;
data_in = 8; we = 1;
#10;
data_in = 9; we = 1;
#10;
data_in = 235; we = 0;
#10;
data_in = 3575; we = 1;
#10;
data_in = 23; we = 0;
#10;
end

always
begin
clk <= 1;
 # 5; 
 clk <= 0;
 # 5; // clock duration
end


always @ (negedge clk)
begin
  if (we)  $display("WE on - data_in: %b  data_out: %b", data_in, data_out);
  else     $display("WE off - data_in: %b  data_out: %b", data_in, data_out);
end


endmodule