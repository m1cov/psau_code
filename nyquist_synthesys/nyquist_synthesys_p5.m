clc
clear

s = tf('s');

K = 100;
G0 = K/(s*(s+1)*(s+5));

Gd = (s+1)/(s+10)
Gi = (s+10)/(s+1)

nyquist(G0);
hold on;
nyquist(G0 * 10)
hold on;
nyquist(G0 * Gd)
hold on;
nyquist(G0 * Gi)
legend('G0 bez komp.', 'komp. so zasiluvanje', 'komp. so Gd', 'komp. so Gi');
hold off;
