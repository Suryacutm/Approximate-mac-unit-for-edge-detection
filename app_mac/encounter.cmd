#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Thu Dec  5 12:09:33 2024                #
#                                                     #
#######################################################

#@(#)CDS: Encounter v13.10-p003_1 (32bit) 04/17/2013 15:43 (Linux 2.6)
#@(#)CDS: NanoRoute v13.10-p002 NR130329-0035/13_10-UB (database version 2.30, 190.4.1) {superthreading v1.19}
#@(#)CDS: CeltIC v13.10-p007_1 (32bit) 04/10/2013 11:52:21 (Linux 2.6.18-194.el5)
#@(#)CDS: AAE 13.10-p003 (32bit) 04/17/2013 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 13.10-p009_1 (32bit) Apr 10 2013 05:45:06 (Linux 2.6.18-194.el5)
#@(#)CDS: CPE v13.10-p010
#@(#)CDS: IQRC/TQRC 12.1.0-s388 (32bit) Fri Mar 29 14:17:34 PDT 2013 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
save_global Default.globals
set init_gnd_net VSS
set init_lef_file {lef/gsclib090_macro.lef lef/gsclib090_tech.lef lef/gsclib090_translated.lef lef/gsclib090_translated_ref.lef}
set init_design_settop 0
set init_verilog app_mac_netlist.v
set init_mmmc_file Default.view
set init_pwr_net VDD
create_library_set -name min_timimg -timing {lib/90/fast.lib}
create_library_set -name max_timing -timing {lib/90/slow.lib}
create_constraint_mode -name app_mac_constrains -sdc_files {app_mac_sdc.sdc}
create_delay_corner -name min_delay -library_set {min_timimg}
create_delay_corner -name max_delay -library_set {max_timing}
create_analysis_view -name worst_case -constraint_mode {app_mac_constrains} -delay_corner {max_delay}
create_analysis_view -name best_case -constraint_mode {app_mac_constrains} -delay_corner {min_delay}
set_analysis_view -setup {worst_case} -hold {best_case}
init_design
save_global Default.globals
set init_gnd_net VSS
set init_lef_file {lef/gsclib090_macro.lef lef/gsclib090_tech.lef lef/gsclib090_translated.lef lef/gsclib090_translated_ref.lef}
set init_design_settop 0
set init_verilog app_mac_netlist.v
set init_mmmc_file Default.view
set init_pwr_net VDD
create_library_set -name min_timimg -timing {lib/90/fast.lib}
create_library_set -name max_timing -timing {lib/90/slow.lib}
create_constraint_mode -name app_mac_constrains -sdc_files {app_mac_sdc.sdc}
create_delay_corner -name min_delay -library_set {min_timimg}
create_delay_corner -name max_delay -library_set {max_timing}
create_analysis_view -name worst_case -constraint_mode {app_mac_constrains} -delay_corner {max_delay}
create_analysis_view -name best_case -constraint_mode {app_mac_constrains} -delay_corner {min_delay}
set_analysis_view -setup {worst_case} -hold {best_case}
init_design
