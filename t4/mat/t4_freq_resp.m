pkg load symbolic;

%gain stage
data = fopen('data_octave.txt','r');
DATA = fscanf(data,'%*s = %f');
fclose(data);

Vin = DATA(2)

VT=25e-3
BFN=178.7
VAFN=69.7
RE1=DATA(9)
RC1=DATA(8)
RB1=DATA(6)
RB2=DATA(7)
VBEON=0.7
VCC = DATA(1)
RS=DATA(4) + 1/(DATA(5)*2*pi*f*i)

Ci = DATA(5)
Co = DATA(12)



RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1


gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

RSB=RB*RS/(RB+RS)




%ouput stage
BFP = 227.3
VAFP = 37.2
RE2 = DATA(11)
VEBON = 0.7
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2

gm2 = IC2/VT
ro2 = VAFP/IC2
rpi2 = BFP/gm2



%total
f = logspace(1, 8, 200)





diary result_octave_lco_uco.txt
diary on
uco = 2123123123123 %fazer esta conta
lco = 2123123123123 %fazer esta conta
bandwidth = 2123123123123 %fazer esta conta
diary off
