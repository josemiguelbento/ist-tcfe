close all
clear all

dataf = fopen('result_sim.txt','r');
DATA = fscanf(dataf,'%*s = %f');
fclose(dataf);

yavg = DATA(1)
ymax = DATA(2)
ymin = DATA(3)
vripple_reg = DATA(4)

%printf('yavg = %.11f\n', DATA(1));
%printf('ymax = %.11f\n', DATA(2));
%printf('ymin = %.11f\n', DATA(3));
%printf('vripple_reg = %.11f\n', DATA(4));

dataf = fopen('data_t3.txt','r');
DATA = fscanf(dataf,'%*s = %f');
fclose(dataf);
