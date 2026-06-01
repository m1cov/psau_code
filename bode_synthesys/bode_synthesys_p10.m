clc
clear

s = tf('s');

K = 1;
G0 = K * 100/(s*(s+50)*(s+100))

Mp = 10;

C = (-log(Mp/100))/sqrt(pi^2 + (log(Mp/100))^2) % ceta preku Mp%

Phi_rf = 100*C % aproksimacija na Phirf preku ceta

% Phirf = 180 + arg(G0) = 59.115 => arg(G0) = -120.885

margin(G0)
grid on;

%% za da Phi_rf = 59.115 => K = 10^(60/20)

K = 10^(59.4/20);
G0 = K * 100/(s*(s+50)*(s+100))

Kv = dcgain(s*G0)

e_stac = double(1/Kv)

e_stac_komp = e_stac/10

Kv_new = 1/e_stac_komp % ova ni ukazhuva deka vo sistemot treba da dodademe zasiluvanje od 10 (Kv_new e 10 pati pogolemo od Kv)

%%
K = 10^(59.4/20) * 10;
G0 = K * 100/(s*(s+50)*(s+100))

margin(G0);
grid on;

% bidejkji sistemot preminuva vo nestabilen, potrebno e da se proektira
% integralen komp. Gi(s) = p/z * (s+z)/(s+p); z > p

%%
corr_factor = 2;

wmax = 15.7 % so korekcionen faktor od 2 stepeni, preku arg(G0) (od prethodno)
mag_wmax = 21;

z_p = 10^(mag_wmax/20);

z = wmax/10; % po konvencija, mozhe da bide 10, 15 itn.
p = z/z_p % z * 1/z/p = z * p/z = p

Gi = 1/z_p * (s+z)/(s+p)

bode(G0, G0*Gi, Gi)
legend('G0_{nc}', 'G0*Gi', 'Gi')
grid on;

%% proverka za e(inf)
clc

K = 10^(59.4/20) * 10;
G0 = K * 100/(s*(s+50)*(s+100))

Gi = p/z * (s+z)/(s+p)

Kv = dcgain(s*G0*Gi)
e_stac = double(1/Kv)
