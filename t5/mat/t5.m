%gain stage
clear all

data = fopen('data_octave.txt','r');
DATA = fscanf(data,'%*s = %f');
fclose(data);


R1 = DATA(6)
R2 = DATA(7)
R3 = DATA(8)
R4 = DATA(9)
C1 = DATA(11)
C2 = DATA(12)

freq = logspace(1,8,100);

Tf = (R1*C1*2*pi*freq*j)./(1+R1*C1*2*pi*freq*j)*(1+R3/R4).*(1./(1+R2*C2*2*pi*freq*j));

f1 = figure();
semilogx(freq,20*log10(abs(Tf)));
xlabel("Frequency [Hz]");
ylabel("Gain [dB]");
title("Gain");
print(f1, "teo_gain.eps", "-depsc");

f2 = figure();
semilogx(freq,180*arg(Tf)/pi);
xlabel("Frequency [Hz]");
ylabel("Phase [Deg]");
title("Phase");
print(f2, "teo_phase.eps", "-depsc");

diary results_oct.txt
diary on
wL = 1/(R1*C1)
wH = 1/(R2*C2)
wO = sqrt(wL*wH)
f = wO/(2*pi)

gain = abs((R1*C1*wO*j)/(1+R1*C1*wO*j)*(1+R3/R4)*(1/(1+R2*C2*wO*j)))
gain_db = 20*log10(abs(gain))

Z_in = abs(R1 + 1/(j*wO*C1))
Z_out = abs(1/(j*wO*C2+1/R2))

diary off

