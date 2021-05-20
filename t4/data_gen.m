close all
clear all

%variables for acdc_conveter-----------------------------------------

diary data_octave.txt
diary on
Vcc = 12
Vinm = 10e-3
Vinf = 1000
Rin = 100
Ci = 1e-3
R1 = 80e3
R2 = 20e3
Rc = 1e3
Re = 100
Cb = 1e-3
Rout = 100
Co = 1e-6
RL = 8

diary off

%variables for ngspice-----------------------------------------

diary data_t4.txt
diary on

printf("Vcc vcc 0 12.0\n")
printf("Vin in 0 0 ac %d sin(0 %d %d)\n",Vinm, Vinm, Vinf)
printf("Rin in in2 %d\n", Rin)
printf("* input coupling capacitor\n")
printf("Ci in2 base %d\n", Ci)
printf("* bias circuit\n")
printf("R1 vcc base %d\n", R1)
printf("R2 base 0 %d\n", R2)
printf("* gain stage\n")
printf("Q1 coll base emit BC547A\n")
printf("Rc vcc coll %d\n", Rc)
printf("Re emit 0 %d\n", Re)
printf("* bypass capacitor\n")
printf("Cb emit 0 %d\n", Cb)
printf("* output stage\n")
printf("Q2 0 coll emit2 BC557A\n")
printf("Rout emit2 vcc %d\n", Rout)
printf("* output coupling capacitor\n")
printf("Co emit2 out %d\n", Co)
printf("* load\n")
printf("RL out 0 %d\n", RL)


diary off

diary data_t4_inc.txt
diary on

printf("Vcc vcc 0 12.0\n")
%printf("Vin in 0 0 ac %d sin(0 %d %d)\n",Vinm ,Vinm, Vinf)
%printf("Rin in in2 %d\n", Rin)
printf("Vin in2 0 0\n")
printf("* input coupling capacitor\n")
printf("Ci in2 base %d\n", Ci)
printf("* bias circuit\n")
printf("R1 vcc base %d\n", R1)
printf("R2 base 0 %d\n", R2)
printf("* gain stage\n")
printf("Q1 coll base emit BC547A\n")
printf("Rc vcc coll %d\n", Rc)
printf("Re emit 0 %d\n", Re)
printf("* bypass capacitor\n")
printf("Cb emit 0 %d\n", Cb)
printf("* output stage\n")
printf("Q2 0 coll emit2 BC557A\n")
printf("Rout emit2 vcc %d\n", Rout)
printf("* output coupling capacitor\n")
printf("Co emit2 out %d\n", Co)
%printf("* load\n")
%printf("RL out 0 %d\n", RL)
printf("Vo out 0 0 ac 1 sin(0 1 %d)\n", Vinf)

diary off





