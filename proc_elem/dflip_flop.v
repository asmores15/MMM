/// Anastasia Frattarole
/// EE 497


module dflip_flop(data_in, clk, reset, data_out);

// PARAMETERS
parameter DATA_WIDTH = 16;
//--------------------------
// INPUTS
input clk, reset;
input [DATA_WIDTH-1:0] data_in;
//--------------------------
// OUTPUTS
output reg [DATA_WIDTH-1:0] data_out;
//--------------------------


always @ (posedge clk)
begin
  if (reset)  data_out <= 16'b0000000000000000;
  else        data_out <= data_in;
end

endmodule