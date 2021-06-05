pkg load symbolic;


data = fopen('data_octave.txt','r');
DATA = fscanf(data,'%*s = %f');
fclose(data);


