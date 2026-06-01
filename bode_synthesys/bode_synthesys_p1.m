clc
clear

s = tf('s');

K = 10^(3.64/20);
R = K;
P = exp(-2*s)/(s+1);

G0 = R*P;
