clc
clear

syms s

P = 1 / (s * (1 + s/8) * (1 + s / 20));

R1 = (1 + 100 * s) / (1 + 120 * s);
R2 = ((1+s) * (1 + 20 * s)) / ((1 + s / 0.01) * (1 + s / 50));
R3 = 100;
R4 = (100 * (1 + s) * (1 + s / 5)) / ((1 + s / 0.01) * (1 + s / 50));


G01 = P * R1;
G02 = P * R2;
G03 = P * R3;
G04 = P * R4;

Kv1 = limit(s*G01, s, 0);
Kv2 = limit(s*G02, s, 0);
Kv3 = limit(s*G03, s, 0);
Kv4 = limit(s*G04, s, 0);

Kv_vals = [Kv1 Kv2 Kv3 Kv4] % => samo R3 i R4 go zadovoluvaat baranjeto 1)

s = tf('s');

P = 1/(s*(1 + s/8)*(1+s/20));
R3 = 100;
R4 = (100*(1+s)*(1+s/5))/((1+s/0.1)*(1+s/50));

G03 = P * R3;
G04 = P * R4;

nyquist(P);
hold on;
nyquist(G03);
hold on;
nyquist(G04);

legend('P bez komp.', 'komp. so R3', 'komp. so R4');
hold off;
