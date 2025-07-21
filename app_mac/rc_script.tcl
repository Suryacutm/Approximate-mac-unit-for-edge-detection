set_attr lib_search_path /home/buet/exchange/app_mac/lib/90
set_attr library slow.lib
set_attr hdl_search_path ./
read_hdl app_mac.v
elaborate
read_sdc constraints_top.sdc
synthesize -to_mapped -effort medium
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge > delays.sdf

write_hdl > app_mac_netlist.v
write_sdc > app_mac_sdc.sdc


gui_show
report timing > app_mac_timing.rep
report power > app_mac_power.rep
report area > app_mac_cell.rep
