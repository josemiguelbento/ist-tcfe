close all
clear all

%variables for opamp bandpass filter-----------------------------------------

% vou deixar as cenas do opamp já diretamente no spice, nao vale a pena estar a passar para aqui
diary data_octave.txt
diary on
Vcc = 5
Vee = -5
Vin_amp_ac = 1
Vin_param2 = 0.01
Vinf = 1000

R1 = 1000
R2 = 1000
R3 = 310e3
R4 = 1000
C1 = 112e-9
C2 = 221e-9



diary off

%variables for ngspice-----------------------------------------

diary data_t5.txt
diary on

printf("Vcc vcc 0 %d\n", Vcc)
printf("Vee vee 0 %d\n", Vee)
printf("Vin in 0 0 ac %d sin(0 %d %d)\n", Vin_amp_ac, Vin_param2, Vinf)

printf("C1 in n_inv %d\n", C1)
printf("R1 n_inv 0 %d\n", R1)
printf("R3 amp inv_in %d\n", R3)
printf("R4 inv_in 0 %d\n", R4)

printf("X1 n_inv inv_in vcc vee amp uA741\n")

printf("R2 amp out %d\n", R2)
printf("C2 out 0 %d\n", C2)


diary off


diary data_t5_inc.txt
diary on

printf("Vcc vcc 0 %d\n", Vcc)
printf("Vee vee 0 %d\n", Vee)
%printf("Vin in 0 0 ac %d sin(0 %d %d)\n", Vin_amp_ac, Vin_param2, Vinf)
printf("Vin in 0 0\n")
printf("C1 in n_inv %d\n", C1)
printf("R1 n_inv 0 %d\n", R1)
printf("R3 amp inv_in %d\n", R3)
printf("R4 inv_in 0 %d\n", R4)

printf("X1 n_inv inv_in vcc vee out uA741\n")

printf("R2 amp out %d\n", R2)
printf("C2 out 0 %d\n", C2)

printf("Vo out 0 0 ac 1 sin(0 1 %d)\n", Vinf)

diary off





