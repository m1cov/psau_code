clc
clear

s = tf('s');

Mp = 20;
C = (-log(Mp/100))/sqrt(pi^2 + (log(Mp/100))^2) % ceta preku Mp%

G0 = 1/(s*(s+5))

rlocus(G0);
sgrid(C, 50);
ylim([-7 7])

% za ceta = 0.456 dominantnite polovi s1/s = -2.5 +- j4.88
% pri K = 30

K = 30;

%% Neidealen D-kompenzator
clc

Gd = (s+6)/(s+11.35)

rlocus(G0*Gd)
sgrid(C, 50)

%% za ceta = 0.456 Kd = 127, no se zema 113 za da se zachuva Mp% = 20%

Gd = 127 * (s+6)/(s+11.35)

step(feedback(G0*Gd, 1))

%% Neidealen I-kompenzator
clc

Gi = (s+0.1)/(s+0.01)

Kv = dcgain(s*G0*Gd)
e_stac = 1/Kv

Kv_comp = dcgain(s*G0*Gd*Gi)
e_stac_comp = 1/Kv_comp

rlocus(G0*Gd);
hold on
rlocus(G0*Gd*Gi)
sgrid(0.456, 50)
hold off;

%% g) aproksimacija so sistem od vtor red
clc

Gk = zpk(feedback(G0 * K, 1))

G0_id = zpk(feedback(G0 * Gd * Gi, 1))

G_approx = 127/(s^2 + 9.919*s + 119.4) % se ponishtuvaat polot vo 6.34 i nulata vo 6; se ponishtuvaat polot vo 0.1007 i nulata vo 0.1

G0_id_0 = dcgain(G0_id); % G0_id(0)
G_approx_0 = dcgain(G_approx); % G_approx(0)

approx_gain = G0_id_0/G_approx_0; % G0_id(0) = G_approx(0)

G_approx = G_approx * approx_gain

step(Gk);
hold on;
step(G0_id);
hold on;
step(G_approx);
legend('G', 'G0 * Gid', 'G_approximated')
hold off;
