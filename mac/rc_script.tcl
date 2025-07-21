set_attr lib_search_path /home/buet/exchange/mac/lib/90
set_attr library slow.lib
set_attr hdl_search_path ./
read_hdl mac.v
elaborate
read_sdc constraints_top.sdc
synthesize -to_mapped -effort medium
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge > delays.sdf

write_hdl > mac_netlist.v
write_sdc > mac_sdc.sdc


gui_show
report timing > mac_timing.rep
report power > mac_power.rep
report area > mac_cell.rep
