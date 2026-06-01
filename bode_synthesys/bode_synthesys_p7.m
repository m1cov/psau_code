clc
clear

s = tf('s');

Mp = 24;
K = 1;

G1 = 25 / (s + 25);
G2 = 10/ (s * (s + 10));

C = (-log(Mp/100))/sqrt(pi^2 + (log(Mp/100))^2)

Phi_rf = atan2d(2*C, sqrt(-2*C^2 + sqrt(1 + 4*C^4)))

%Phi_rf = 44.3743 => arg(G0) = 44.3743 - 180 = -135.6257
% 20*log10(K) = 17.4 dB => K = 10^(17.4/20)

K = 10^(17.4/20);
G0 = K * G1 * G2;

margin(G0);
grid on;

step(feedback(G0, 1))


