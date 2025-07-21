#######################################################
#                                                     #
#  Encounter Command Logging File                     #
#  Created on Wed Dec  4 16:10:29 2024                #
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
set init_lef_file {lef/gsclib090_translated_ref.lef lef/gsclib090_tech.lef lef/gsclib090_macro.lef lef/gsclib090_translated.lef}
set init_design_settop 0
set init_verilog mac_netlist.v
set init_mmmc_file Default.view
set init_pwr_net VDD
create_library_set -name max_timing -timing {lib/90/slow.lib}
create_library_set -name min_timing -timing {lib/90/fast.lib}
create_constraint_mode -name mac_constrains -sdc_files {mac_sdc.sdc}
create_delay_corner -name min_delay -library_set {min_timing}
create_delay_corner -name max_delay -library_set {max_timing}
create_analysis_view -name worst_case -constraint_mode {mac_constrains} -delay_corner {max_delay}
create_analysis_view -name best_case -constraint_mode {mac_constrains} -delay_corner {min_delay}
set_analysis_view -setup {worst_case} -hold {best_case}
init_design
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site gsclib090site -r 0.956178667042 0.700003 10 10 10 10
uiSetTool select
getIoFlowFlag
fit
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -stacked_via_top_layer Metal9 -around core -jog_distance 0.435 -threshold 0.435 -nets {VDD VSS} -stacked_via_bottom_layer Metal1 -layer {bottom Metal5 top Metal5 right Metal9 left Metal9} -width 2 -spacing 2 -offset 0.435
set sprCreateIeStripeNets {}
set sprCreateIeStripeLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeSpacing 2.0
set sprCreateIeStripeThreshold 1.0
addStripe -block_ring_top_layer_limit Metal7 -max_same_layer_jog_length 0.88 -padcore_ring_bottom_layer_limit Metal5 -set_to_set_distance 100 -stacked_via_top_layer Metal9 -padcore_ring_top_layer_limit Metal7 -spacing 2 -merge_stripes_value 0.435 -layer Metal6 -block_ring_bottom_layer_limit Metal5 -width 2 -nets {VDD VSS} -stacked_via_bottom_layer Metal1
undo
addStripe -block_ring_top_layer_limit Metal7 -max_same_layer_jog_length 0.88 -padcore_ring_bottom_layer_limit Metal5 -number_of_sets 3 -stacked_via_top_layer Metal9 -padcore_ring_top_layer_limit Metal7 -spacing 2 -merge_stripes_value 0.435 -layer Metal6 -block_ring_bottom_layer_limit Metal5 -width 2 -nets {VDD VSS} -stacked_via_bottom_layer Metal1
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { Metal1 Metal6 } -blockPinTarget { nearestRingStripe nearestTarget } -padPinPortConnect { allPort oneGeom } -stripeSCpinTarget { blockring padring ring stripe ringpin blockpin } -checkAlignedSecondaryPin 1 -blockPin useLef -allowJogging 1 -crossoverViaBottomLayer Metal1 -allowLayerChange 1 -targetViaTopLayer Metal9 -crossoverViaTopLayer Metal9 -targetViaBottomLayer Metal1 -nets { VDD VSS }
setPlaceMode -fp false
placeDesign -prePlaceOpt
fit
zoomIn
zoomIn
zoomIn
setLayerPreference stdCell -isVisible 0
setLayerPreference stdCell -isVisible 1
zoomIn
zoomIn
panPage -1 0
panPage -1 0
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 -1
panPage 0 1
panPage 0 1
panPage 0 1
fit
checkPlace hybrid_mac.checkPlace
setDrawView place
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix hybrid_mac_preCTS -outDir timingReports
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -preCTS
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix hybrid_mac_preCTS -outDir timingReports
createClockTreeSpec -bufferList {CLKBUFX12 CLKBUFX16 CLKBUFX2 CLKBUFX20 CLKBUFX3 CLKBUFX4 CLKBUFX6 CLKBUFX8 CLKINVX1 CLKINVX12 CLKINVX16 CLKINVX2 CLKINVX20 CLKINVX3 CLKINVX4 CLKINVX6 CLKINVX8} -file Clock.ctstch
createClockTreeSpec -bufferList {CLKBUFX12 CLKBUFX16 CLKBUFX2 CLKBUFX20 CLKBUFX3 CLKBUFX4 CLKBUFX6 CLKBUFX8 CLKINVX1 CLKINVX12 CLKINVX16 CLKINVX2 CLKINVX20 CLKINVX3 CLKINVX4 CLKINVX6 CLKINVX8} -file Clock.ctstch
clockDesign -specFile Clock.ctstch -outDir clock_report -fixedInstBeforeCTS
clockDesign -specFile Clock.ctstch -outDir clock_report -fixedInstBeforeCTS
setLayerPreference pinObj -isVisible 1
setLayerPreference cellBlkgObj -isVisible 1
setLayerPreference layoutObj -isVisible 1
setLayerPreference pinObj -isVisible 0
setLayerPreference cellBlkgObj -isVisible 0
setLayerPreference layoutObj -isVisible 0
setLayerPreference areaIo -isVisible 0
setLayerPreference areaIo -isVisible 1
setLayerPreference phyCell -isVisible 0
setLayerPreference phyCell -isVisible 1
setLayerPreference block -isVisible 0
setLayerPreference block -isVisible 1
fit
setLayerPreference mGrid -isVisible 1
setLayerPreference pGrid -isVisible 1
setLayerPreference userGrid -isVisible 1
setLayerPreference gcell -isVisible 1
setLayerPreference mGrid -isVisible 0
setLayerPreference pGrid -isVisible 0
setLayerPreference userGrid -isVisible 0
setLayerPreference gcell -isVisible 0
setLayerPreference trackObj -isVisible 1
setLayerPreference nonPrefTrackObj -isVisible 1
setLayerPreference trackObj -isVisible 0
setLayerPreference nonPrefTrackObj -isVisible 0
setLayerPreference blackBox -isVisible 0
setLayerPreference blackBox -isVisible 1
setLayerPreference blackBox -isSelectable 0
setLayerPreference blackBox -isSelectable 1
setLayerPreference blackBlob -isVisible 0
setLayerPreference blackBlob -isVisible 1
setLayerPreference pinObj -isVisible 1
setLayerPreference cellBlkgObj -isVisible 1
setLayerPreference layoutObj -isVisible 1
setLayerPreference pinObj -isVisible 0
setLayerPreference cellBlkgObj -isVisible 0
setLayerPreference layoutObj -isVisible 0
zoomIn
zoomIn
zoomIn
zoomOut
zoomOut
zoomOut
panPage 1 0
panPage -1 0
selectInst vedic_mult/vm2/FE_RC_415_0
deselectAll
setLayerPreference pwrdm -isVisible 0
setLayerPreference netRect -isVisible 0
setLayerPreference substrateNoise -isVisible 0
setLayerPreference powerNet -isVisible 0
setLayerPreference pwrdm -isVisible 1
setLayerPreference netRect -isVisible 1
setLayerPreference substrateNoise -isVisible 1
setLayerPreference powerNet -isVisible 1
setLayerPreference inst -isVisible 0
setLayerPreference block -isVisible 0
setLayerPreference stdCell -isVisible 0
setLayerPreference coverCell -isVisible 0
setLayerPreference phyCell -isVisible 0
setLayerPreference io -isVisible 0
setLayerPreference areaIo -isVisible 0
setLayerPreference blackBox -isVisible 0
setLayerPreference blackBlob -isVisible 0
setLayerPreference inst -isVisible 1
setLayerPreference block -isVisible 1
setLayerPreference stdCell -isVisible 1
setLayerPreference coverCell -isVisible 1
setLayerPreference phyCell -isVisible 1
setLayerPreference io -isVisible 1
setLayerPreference areaIo -isVisible 1
setLayerPreference blackBox -isVisible 1
setLayerPreference blackBlob -isVisible 1
setLayerPreference pinObj -isVisible 1
setLayerPreference pinObj -isVisible 0
setLayerPreference pinObj -isVisible 1
setLayerPreference cellBlkgObj -isVisible 1
setLayerPreference layoutObj -isVisible 1
setLayerPreference pinObj -isSelectable 1
setLayerPreference cellBlkgObj -isSelectable 1
setLayerPreference layoutObj -isSelectable 1
setLayerPreference pinObj -isSelectable 0
setLayerPreference cellBlkgObj -isSelectable 0
setLayerPreference layoutObj -isSelectable 0
setLayerPreference pinObj -isVisible 0
setLayerPreference cellBlkgObj -isVisible 0
setLayerPreference layoutObj -isVisible 0
setLayerPreference relFPlan -isVisible 0
setLayerPreference sdpGroup -isVisible 0
setLayerPreference sdpConnect -isVisible 0
setLayerPreference sizeBlkg -isVisible 0
setLayerPreference resizeFPLine1 -isVisible 0
setLayerPreference resizeFPLine2 -isVisible 0
setLayerPreference congTag -isVisible 0
setLayerPreference ioSlot -isVisible 0
setLayerPreference overlapMacro -isVisible 0
setLayerPreference overlapGuide -isVisible 0
setLayerPreference overlapBlk -isVisible 0
setLayerPreference datapath -isVisible 0
setLayerPreference relFPlan -isVisible 1
setLayerPreference sdpGroup -isVisible 1
setLayerPreference sdpConnect -isVisible 1
setLayerPreference sizeBlkg -isVisible 1
setLayerPreference resizeFPLine1 -isVisible 1
setLayerPreference resizeFPLine2 -isVisible 1
setLayerPreference congTag -isVisible 1
setLayerPreference ioSlot -isVisible 1
setLayerPreference overlapMacro -isVisible 1
setLayerPreference overlapGuide -isVisible 1
setLayerPreference overlapBlk -isVisible 1
setLayerPreference datapath -isVisible 1
setLayerPreference pwrdm -isVisible 0
setLayerPreference netRect -isVisible 0
setLayerPreference substrateNoise -isVisible 0
setLayerPreference powerNet -isVisible 0
setLayerPreference pwrdm -isVisible 1
setLayerPreference netRect -isVisible 1
setLayerPreference substrateNoise -isVisible 1
setLayerPreference powerNet -isVisible 1
setLayerPreference allM0 -isVisible 0
setLayerPreference allM0 -isVisible 1
setLayerPreference allM1Cont -isVisible 0
setLayerPreference allM1Cont -isVisible 1
setLayerPreference areaIo -isVisible 0
setLayerPreference areaIo -isVisible 1
zoomIn
zoomIn
zoomIn
panPage 1 0
panPage 1 0
panPage 1 0
uiSetTool stretchWire
panPage -1 0
panPage -1 0
panPage 1 0
selectPhyPin 90.5450 45.6050 91.1200 45.7450 7 {weight[1]}
fit
setLayerPreference obstruct -isVisible 0
setLayerPreference screen -isVisible 0
setLayerPreference macroOnly -isVisible 0
setLayerPreference layerBlk -isVisible 0
setLayerPreference blockHalo -isVisible 0
setLayerPreference routingHalo -isVisible 0
setLayerPreference blkLink -isVisible 0
setLayerPreference obstruct -isVisible 1
setLayerPreference screen -isVisible 1
setLayerPreference macroOnly -isVisible 1
setLayerPreference layerBlk -isVisible 1
setLayerPreference blockHalo -isVisible 1
setLayerPreference routingHalo -isVisible 1
setLayerPreference blkLink -isVisible 1
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postCTS -pathReports -drvReports -slackReports -numPaths 50 -prefix hybrid_mac_postCTS -outDir timingReports
setLayerPreference blackBox -isSelectable 0
setLayerPreference blackBox -isSelectable 1
setLayerPreference blackBox -isSelectable 0
setLayerPreference blackBox -isSelectable 1
setLayerPreference blackBox -isSelectable 0
setLayerPreference blackBox -isVisible 0
setLayerPreference blackBox -isVisible 1
setLayerPreference blackBox -isSelectable 1
deselectAll
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeTdrEffort 2
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -routeTopRoutingLayer 9
setNanoRouteMode -quiet -routeBottomRoutingLayer 1
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
setNanoRouteMode -quiet -routeWithTimingDriven 1
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven true
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
zoomIn
zoomIn
zoomOut
zoomOut
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000 -warning 50
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
verifyConnectivity -type all -error 1000 -warning 50
streamOut mac_GDS2 -mapFile streamOut.map -libName DesignLib -units 2000 -mode ALL
