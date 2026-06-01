clc
clear

s = tf('s');

K = 10000;
G0 = K / ((s + 5) * (s + 20) * (s + 50));

margin(G0);
hold on
