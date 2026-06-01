clc
clear

s = tf('s');
G0 = 1/(s*(s+5))

% pri sinteza so GMK sekogash prvo se nagoduva PREODEN odziv, a potoa
% STACIONAREN

rlocus(G0)

ceta = 0.592;
wn = 50;

sgrid(ceta, wn)
ylim([-7, 7])

K_dobieno = 17.8

% za da C = 0.592 potrebno e K da bide 17.8, a pritoa se dobivaat
% dominantni polovi s12 = -2.5 +- j3.4

%%
clc

Kv = dcgain(s*K_dobieno*G0)
e_stac = 1/Kv

% za presmetanata vrednost na K = 17.8 se dobiva ev(inf) = 28%, shto e
% mnogu pogolema od baranata vrednost od ev(inf) = 2%

e_stac_posakuvano = 0.02

e_stac_dobieno = 5/K_dobieno

gain_needed = e_stac_dobieno/e_stac_posakuvano

%% gain_needed e vsushnost potrebniot odnos z/p na kompenzatorot

z_p = gain_needed

z = 0.1; % proizvolna vrednost vo blizina na Im-oskata
p = z * 1/(z_p);

Gi = (s+z)/(s+p);

rlocus(G0)
hold on;
rlocus(G0*Gi)
sgrid(0.592, 50)
ylim([-7, 7])

%% Proverka
clc

Kv_new = dcgain(s*K_dobieno*G0*Gi)
e_stac_new = 1/Kv_new

%% Sporedba na odzivi
K = 17.8
G0 = 1/(s*(s+5));
Gi = (s+z)/(s+p)

t = 0:0.01:100;

lsim(feedback(G0, 1), t, t);
hold on;
lsim(feedback(K*G0, 1), t, t);
hold on;
lsim(feedback(K*G0*Gi, 1), t, t);
legend('G0', 'K*G0', 'K*G0*Gi')
