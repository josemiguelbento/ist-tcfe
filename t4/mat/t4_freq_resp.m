pkg load symbolic;

%gain stage
data = fopen('data_octave.txt','r');
DATA = fscanf(data,'%*s = %f');
fclose(data);

size = 200

freq = logspace(1, 8, size);
gain = zeros(1,size);
gain_db = zeros(1,size);

for a = 1:1:200
f = freq(a);

Vin = DATA(2)*e^(i*2*pi*f); %------------------------------

VT=25e-3; %------------------------------
BFN=178.7; %------------------------------
VAFN=69.7; %----------------------
RE1=DATA(9); %------------------------------
RC1=DATA(8); %--------------------------
RB1=DATA(6);
RB2=DATA(7);
VBEON=0.7; %------------------------------
VCC = DATA(1); %------------------------------

Ci = DATA(5); %------------------------------
Co = DATA(12); %------------------------------
Cb = DATA(10);%------------------------------
RL = DATA(13); %------------------------------

Rin=DATA(4); %---------------------------------
RS = Rin;
Zci = 1/(Ci*2*pi*f*i); %----------------------
Zcb = 1/(Cb*2*pi*f*i); %----------------------
Zco = 1/(Co*2*pi*f*i); %----------------------



RB=1/(1/RB1+1/RB2); %-------------------------
VEQ=RB2/(RB1+RB2)*VCC;
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1); %------------------------------
IC1=BFN*IB1; %------------------------------
IE1=(1+BFN)*IB1;
VE1=RE1*IE1;
VO1=VCC-RC1*IC1;
VCE=VO1-VE1;


gm1=IC1/VT; %------------------------------
rpi1=BFN/gm1; %------------------------------
ro1=VAFN/IC1;%---------------------------

RSB=RB*RS/(RB+RS);




%ouput stage
BFP = 227.3; %------------------------------
VAFP = 37.2; %------------------------------
RE2 = DATA(11); %------------------------------
VEBON = 0.7; %------------------------------
VI2 = VO1; %------------------------------
IE2 = (VCC-VEBON-VI2)/RE2; %------------------------------
IC2 = BFP/(BFP+1)*IE2; %------------------------------
VO2 = VCC - RE2*IE2;

gm2 = IC2/VT; %------------------------------
ro2 = VAFP/IC2; %------------------------------
rpi2 = BFP/gm2;  %----------------------



%total
palhacada =  -gm2 -1/rpi2;
%pq o octave e estupido e qd eu meto isto na matriz acha q isto e 1:2

%var =[v1,v2,v3,v4,v5,v6,v7]
Y =[1,0,0,0,0,0,0;
-1/Rin, 1/Rin+1/Zci, -1/Zci, 0,0,0,0;
0, -1/Zci, 1/Zci+1/RB+1/rpi1, -1/rpi1,0,0,0;
0,0,-gm1-1/rpi1, gm1+1/rpi1 + 1/RE1 + 1/Zcb + 1/ro1, -1/ro1, 0,0;
0,0, gm1, -gm1-1/ro1, 1/ro1 + 1/RC1 + 1/rpi2, -1/rpi2, 0;
0,0,0,0,0, -1/Zco, 1/Zco + 1/RL;
0,0,0,0, palhacada, gm2 + 1/rpi2 + 1/RE2 + 1/Zco + 1/ro2, -1/Zco;
];


B=[Vin; 0; 0; 0; 0; 0; 0];

X = Y\B;

gain(a) = abs(X(7)/X(1));
gain_db(a) = 20*log10(gain(a));

endfor

hfa = figure (1);
semilogx(freq, gain,";gain(f);");
xlabel ("f [Hz]");
ylabel ("gain");
%legend('gain(f)','Location','northwest');
print (hfa, "gain_octave.odg", "-depsc");
hfb = figure (2);
semilogx(freq, gain_db,";gain(f) Db;");
xlabel ("f [Hz]");
ylabel ("gain Db");
%legend('gain(f) Db','Location','northwest');
print (hfb, "gain_db_octave.odg", "-depsc");



%buscar o ganho teorico/---------------------
datar = fopen('result_octave.txt','r');
DATAR = fscanf(datar,'%*s = %f');
fclose(datar);

gain_oct = DATAR(7);

gain_cutoff_db = 20*log10(gain_oct) - 3
gain_cutoff = 10^(gain_cutoff_db/20)

ref = abs(gain(1)-gain_cutoff)
for i = 2:1:200
  if abs(gain(i)-gain_cutoff) < ref
  	freq_cutoff = freq(i)
  	ref = abs(gain(i)-gain_cutoff)
  endif
endfor
LCO = freq_cutoff

diary result_octave_lco_uco.txt
diary on
uco = 2123123123123 %fazer esta conta
lco = LCO %fazer esta conta
bandwidth = 2123123123123 %fazer esta conta
diary off
