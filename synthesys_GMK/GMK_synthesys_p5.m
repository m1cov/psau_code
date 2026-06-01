clc
clear

s = tf('s');

G0 = 20/(s*(s+10)^2)

Kv = dcgain(s*G0)
e_stac = 1/Kv

e_stac_new = e_stac/100
Kv_new = 1/e_stac_new

gain_needed = Kv_new/Kv % od tuka go naogjame potrebnoto zasiluvanje

% gain_needed e baraniot soodnost pomegju nulata i polot z_p na komp.

% Gi(s) = (s+z)/(s+p); z > p

z_p = gain_needed;

z = 0.1; % proizvolna vrednost vo blizina na imaginarnata oska
p = z * 1/z_p; % se presmetuva spored potrebniot soodnos i proizvolnata nula

Gi = (s+z)/(s+p)

rlocus(G0)
hold on;
rlocus(G0*Gi) % mozhe da se uvidi deka GMK e skoro nepromeneto

%% proverka
clc

Kv = dcgain(s*G0*Gi)

e_stac = 1/Kv

