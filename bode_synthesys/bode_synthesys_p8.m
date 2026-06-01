clc
clear

syms s K

G0 = K / (s * (s + 10));

Kv = limit(s * G0, s, 0);

e_stac = 1 / Kv;

sol = solve(e_stac <= 0.05, 'ReturnConditions', true);
sol.conditions

s = tf('s');

K = 200;
G0 = K/(s*(s+10))

margin(G0);
grid on;

%% se proektira dif. kompenzator Gd(s) = p/z * (s+z)/(s+p); z < p

Phirf_wanted = 45;
Phirf_current = 38.7;
corr_factor = 5; % korekcionen faktor so cel da se nadomesti slabeenjeto od komp., mozhe da bide od 5 do 12 stepeni

% maksimalnata pozitivna faza shto ja vnesuva diff. komp.
Phimax = Phirf_wanted - Phirf_current + corr_factor

% soodnos nula/pol -> z/p
z_p = (1 - sind(Phimax))/(1 + sind(Phimax))

% magnitudata na amplitudniot dijagram pri frekvencija wmax
mag_wmax = 20*log10(1/sqrt(z_p))

% wmax se opredeluva od bodeovite dijagrami (preku mag_wmax)
wmax = 11;

% wmax = sqrt(p*z) => sqrt(p*z) * sqrt(z/p) = z;
% sqrt(p*z) * 1/sqrt(z/p) = sqrt(p*z) * sqrt(p/z) = p

z = wmax*sqrt(z_p);
p = z/z_p;

Gd = p/z * (s+z)/(s+p);

bode(G0, G0*Gd, Gd)
legend('G0_{nc}', 'G0*Gd', 'Gd')
grid on;

%% proverka za a)

Kv = dcgain(G0*Gd*s)

e_stac = 1/Kv


