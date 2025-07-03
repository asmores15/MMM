module reg_file(write, clk, reset, data_in, data_out);

//--------------------------
// PARAMETERS
parameter DATA_WIDTH = 16;
//--------------------------
// INPUTS
input write, clk, reset;
input [DATA_WIDTH-1:0] data_in;
//--------------------------
// OUTPUTS
output reg [DATA_WIDTH-1:0] data_out;
//--------------------------

always @ (posedge clk, posedge reset)
begin
  if (reset) data_out <= 0;
  else if (write)  data_out <= data_in;
  else             data_out <= data_out;
end

endmodule