module baud_rate_gen(
    input wire clk_50m,
    output wire rxclk_en,
    output wire txclk_en
);

parameter RX_ACC_MAX = 50000000 / (115200 * 16);
parameter TX_ACC_MAX = 50000000 / 115200;
parameter RX_ACC_WIDTH = $clog2(RX_ACC_MAX);
parameter TX_ACC_WIDTH = $clog2(TX_ACC_MAX);

reg [RX_ACC_WIDTH-1:0] rx_acc = 0;
reg [TX_ACC_WIDTH-1:0] tx_acc = 0;

assign rxclk_en = (rx_acc == 0);
assign txclk_en = (tx_acc == 0);

always @(posedge clk_50m) begin
    if (rx_acc == RX_ACC_MAX[RX_ACC_WIDTH-1:0])
        rx_acc <= 0;
    else
        rx_acc <= rx_acc + 1'b1;
end

always @(posedge clk_50m) begin
    if (tx_acc == TX_ACC_MAX[TX_ACC_WIDTH-1:0])
        tx_acc <= 0;
    else
        tx_acc <= tx_acc + 1'b1;
end

endmodule
