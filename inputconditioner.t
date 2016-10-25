#! /usr/bin/vvp
:ivl_version "0.9.7 " "(v0_9_7)";
:vpi_time_precision + 0;
:vpi_module "system";
:vpi_module "v2005_math";
:vpi_module "va_math";
S_0x158a4b0 .scope module, "testConditioner" "testConditioner" 2 5;
 .timescale 0 0;
v0x159fc00_0 .var "clk", 0 0;
v0x159fca0_0 .net "conditioned", 0 0, v0x159f560_0; 1 drivers
v0x159fd50_0 .net "falling", 0 0, v0x159f7f0_0; 1 drivers
v0x159fe00_0 .var "pin", 0 0;
v0x159fee0_0 .net "rising", 0 0, v0x159f970_0; 1 drivers
S_0x158a5a0 .scope module, "dut" "inputconditioner" 2 13, 3 8, S_0x158a4b0;
 .timescale 0 0;
P_0x1588f28 .param/l "counterwidth" 3 17, +C4<011>;
P_0x1588f50 .param/l "waittime" 3 18, +C4<011>;
v0x1577e10_0 .net "clk", 0 0, v0x159fc00_0; 1 drivers
v0x159f560_0 .var "conditioned", 0 0;
v0x159f600_0 .var "counter", 2 0;
v0x159f6a0_0 .var "dff0", 0 0;
v0x159f750_0 .var "dff1", 0 0;
v0x159f7f0_0 .var "negativeedge", 0 0;
v0x159f8d0_0 .net "noisysignal", 0 0, v0x159fe00_0; 1 drivers
v0x159f970_0 .var "positiveedge", 0 0;
v0x159fa60_0 .var "synchronizer0", 0 0;
v0x159fb00_0 .var "synchronizer1", 0 0;
E_0x15655c0 .event posedge, v0x1577e10_0;
    .scope S_0x158a5a0;
T_0 ;
    %set/v v0x159f600_0, 0, 3;
    %end;
    .thread T_0;
    .scope S_0x158a5a0;
T_1 ;
    %set/v v0x159fa60_0, 0, 1;
    %end;
    .thread T_1;
    .scope S_0x158a5a0;
T_2 ;
    %set/v v0x159fb00_0, 0, 1;
    %end;
    .thread T_2;
    .scope S_0x158a5a0;
T_3 ;
    %set/v v0x159f6a0_0, 0, 1;
    %end;
    .thread T_3;
    .scope S_0x158a5a0;
T_4 ;
    %set/v v0x159f750_0, 0, 1;
    %end;
    .thread T_4;
    .scope S_0x158a5a0;
T_5 ;
    %wait E_0x15655c0;
    %ix/load 0, 1, 0;
    %assign/v0 v0x159f970_0, 0, 0;
    %ix/load 0, 1, 0;
    %assign/v0 v0x159f7f0_0, 0, 0;
    %load/v 8, v0x159f560_0, 1;
    %load/v 9, v0x159fb00_0, 1;
    %cmp/u 8, 9, 1;
    %jmp/0xz  T_5.0, 4;
    %ix/load 0, 3, 0;
    %assign/v0 v0x159f600_0, 0, 0;
    %jmp T_5.1;
T_5.0 ;
    %load/v 8, v0x159f600_0, 3;
    %mov 11, 0, 1;
    %cmpi/u 8, 3, 4;
    %jmp/0xz  T_5.2, 4;
    %ix/load 0, 3, 0;
    %assign/v0 v0x159f600_0, 0, 0;
    %load/v 8, v0x159fb00_0, 1;
    %ix/load 0, 1, 0;
    %assign/v0 v0x159f560_0, 0, 8;
    %load/v 8, v0x159fb00_0, 1;
    %jmp/0xz  T_5.4, 8;
    %load/v 8, v0x159fb00_0, 1;
    %ix/load 0, 1, 0;
    %assign/v0 v0x159f970_0, 0, 8;
    %jmp T_5.5;
T_5.4 ;
    %load/v 8, v0x159fb00_0, 1;
    %inv 8, 1;
    %ix/load 0, 1, 0;
    %assign/v0 v0x159f7f0_0, 0, 8;
T_5.5 ;
    %jmp T_5.3;
T_5.2 ;
    %load/v 8, v0x159f600_0, 3;
    %mov 11, 0, 29;
    %addi 8, 1, 32;
    %ix/load 0, 3, 0;
    %assign/v0 v0x159f600_0, 0, 8;
T_5.3 ;
T_5.1 ;
    %load/v 8, v0x159f8d0_0, 1;
    %ix/load 0, 1, 0;
    %assign/v0 v0x159fa60_0, 0, 8;
    %load/v 8, v0x159fa60_0, 1;
    %ix/load 0, 1, 0;
    %assign/v0 v0x159fb00_0, 0, 8;
    %jmp T_5;
    .thread T_5;
    .scope S_0x158a4b0;
T_6 ;
    %set/v v0x159fc00_0, 0, 1;
    %end;
    .thread T_6;
    .scope S_0x158a4b0;
T_7 ;
    %delay 10, 0;
    %load/v 8, v0x159fc00_0, 1;
    %inv 8, 1;
    %set/v v0x159fc00_0, 8, 1;
    %jmp T_7;
    .thread T_7;
    .scope S_0x158a4b0;
T_8 ;
    %set/v v0x159fe00_0, 0, 1;
    %end;
    .thread T_8;
    .scope S_0x158a4b0;
T_9 ;
    %vpi_call 2 29 "$dumpfile", "inputconditioner.vcd";
    %vpi_call 2 30 "$dumpvars";
    %delay 100, 0;
    %delay 7, 0;
    %set/v v0x159fe00_0, 1, 1;
    %delay 20, 0;
    %set/v v0x159fe00_0, 0, 1;
    %delay 20, 0;
    %set/v v0x159fe00_0, 1, 1;
    %delay 20, 0;
    %set/v v0x159fe00_0, 0, 1;
    %delay 105, 0;
    %delay 2, 0;
    %set/v v0x159fe00_0, 1, 1;
    %delay 2, 0;
    %set/v v0x159fe00_0, 0, 1;
    %delay 2, 0;
    %set/v v0x159fe00_0, 1, 1;
    %delay 2, 0;
    %set/v v0x159fe00_0, 0, 1;
    %delay 2, 0;
    %set/v v0x159fe00_0, 1, 1;
    %delay 2, 0;
    %set/v v0x159fe00_0, 0, 1;
    %delay 2, 0;
    %set/v v0x159fe00_0, 1, 1;
    %delay 2, 0;
    %set/v v0x159fe00_0, 0, 1;
    %delay 100, 0;
    %delay 50, 0;
    %set/v v0x159fe00_0, 1, 1;
    %delay 100, 0;
    %set/v v0x159fe00_0, 0, 1;
    %delay 150, 0;
    %set/v v0x159fe00_0, 1, 1;
    %delay 200, 0;
    %set/v v0x159fe00_0, 0, 1;
    %delay 100, 0;
    %vpi_call 2 54 "$finish";
    %end;
    .thread T_9;
# The file index is used to find the file name in the following table.
:file_names 4;
    "N/A";
    "<interactive>";
    "inputconditioner.t.v";
    "inputconditioner.v";