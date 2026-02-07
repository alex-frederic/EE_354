# Reading C:/questasim64_10.4c/tcl/vsim/pref.tcl
# //  Questa Sim-64
# //  Version 10.4c win64 Jul 20 2015
# //
# //  Copyright 1991-2015 Mentor Graphics Corporation
# //  All Rights Reserved.
# //
# //  THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
# //  WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION OR ITS
# //  LICENSORS AND IS SUBJECT TO LICENSE TERMS.
# //  THIS DOCUMENT CONTAINS TRADE SECRETS AND COMMERCIAL OR FINANCIAL
# //  INFORMATION THAT ARE PRIVILEGED, CONFIDENTIAL, AND EXEMPT FROM
# //  DISCLOSURE UNDER THE FREEDOM OF INFORMATION ACT, 5 U.S.C. SECTION 552.
# //  FURTHERMORE, THIS INFORMATION IS PROHIBITED FROM DISCLOSURE UNDER
# //  THE TRADE SECRETS ACT, 18 U.S.C. SECTION 1905.
# //
# Loading project middle_finder
# Compile of middle_finder.v was successful.
# Compile of middle_finder_tb.v was successful.
# Compile of middle_finder.v was successful.
# Compile of middle_finder_tb.v was successful.
# 2 compiles, 0 failed with no errors.
vsim -gui work.middle_finder_tb -novopt
# vsim -gui work.middle_finder_tb -novopt 
# Start time: 23:25:32 on Jan 12,2026
# ** Warning: (vsim-8891) All optimizations are turned off because the -novopt switch is in effect. This will cause your simulation to run very slowly. If you are using this switch to preserve visibility for Debug or PLI features please see the User's Manual section on Preserving Object Visibility with vopt.
# 
# Refreshing C:/Users/Dinkley/Documents/ee370_labs/Lab 1/middle_finder/work.middle_finder_tb
# Loading work.middle_finder_tb
# Refreshing C:/Users/Dinkley/Documents/ee370_labs/Lab 1/middle_finder/work.middle_finder
# Loading work.middle_finder
add wave sim:/middle_finder_tb/*
# Causality operation skipped due to absence of debug database file
run 30ns
