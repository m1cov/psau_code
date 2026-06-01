clc
clear

s = tf('s');

P = exp(-0.2* s)/(s+5);

K = 1;
R = K;

G0 = R*P;

nyquist(G0); # Se cita od grafikot 21.1dB
hold on

# 20log10(K) = 21.1

K = 10^(21.1/20)
R = K;

G0 = R*P;

nyquist(G0);
legend('G0', 'G0_comp');

clc

K = 1;
R = K;
G0 = R*P;

margin(G0);
grid on;

%% -> 20*log10(K) = 18.4 dB

K = 10^(18.4/20)

R = K;
G0 = R*P;

margin(G0); % -> d = 2.67 dB

