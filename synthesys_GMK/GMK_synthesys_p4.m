clc
clear

syms K s G0

G = K/((s+25)^2 + K);

G0 = solve(G == G0/(1+G0), G0);

% G0 se dobiva deka e G0 = K/(s+25)^2

s = tf('s');

G0 = 1/(s+25)^2

rlocus(G0)
sgrid(0.707, 50)
ylim([-30 30])

% za ceta = 0.707 potrebno e K da bide K = 625 so shto se dobivaat d.p.
% s_1/2 = -25 +- j25

K = 625;
pole(feedback(G0*K, 1))
