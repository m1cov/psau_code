clc
clear

s = tf('s');

G0 = (s+2)/(s^2 + 4*s + 5)

rlocus(G0)

K = 2;
pole(feedback(K*G0, 1))
