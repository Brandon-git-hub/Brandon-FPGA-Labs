# -----------------------------------------------------------
# 1. 設置時鐘
# -----------------------------------------------------------
create_clock -name sys_clk -period 20.0 [get_ports {CLOCK_50}]

# -----------------------------------------------------------
# 2. 設置輸入延遲 (INPUT DELAYS)
# -----------------------------------------------------------
# 假設外部晶片資料在時鐘週期 50% 的時間內到達
# -max (建立時間要求): 外部資料最晚到達的時間 (例如週期 40% = 4 ns)
# -min (保持時間要求): 外部資料最早到達的時間 (例如週期 -10% = -1 ns)
set_input_delay -max 4.0 -clock sys_clk [get_ports {SW[*]}]
set_input_delay -min -1.0 -clock sys_clk [get_ports {SW[*]}]
set_input_delay -max 4.0 -clock sys_clk [get_ports {KEY[*]}]
set_input_delay -min -1.0 -clock sys_clk [get_ports {KEY[*]}]

# -----------------------------------------------------------
# 3. 設置輸出延遲 (OUTPUT DELAYS)
# -----------------------------------------------------------
# 假設 FPGA 輸出資料必須在時鐘週期 60% 的時間內被外部晶片鎖存
# -max (建立時間要求): 外部晶片最晚需要的時間 (例如週期 60% = 6 ns)
# -min (保持時間要求): 外部晶片最早需要鎖存的時間 (例如週期 0% = 0 ns)
set_output_delay -max 6.0 -clock sys_clk [get_ports {LED*}]
set_output_delay -min 0.0 -clock sys_clk [get_ports {LED*}]