clc
clear

s = tf('s');

G0 = 1/((s+2)*(s+4)*(s+8))

rlocus(G0)
sgrid(0.18, 50)

K_dobieno = 316;

% za da C = 0.18 potrebno e K = 316, a pritoa se dobivaat dominantni polovi
% s12 = -1.01 +- j5.54

%% idealen I-kompenzator -> G(i) = (s+zi)/s; pi=0; z_p = z/0 = inf.
% za da e(inf) = 0, potrebno e da se vovede astatizam od prv red

z = 0.01; % proizvolna vrednost vo blizina na Im-oskata

Gi = (s+z)/s

rlocus(G0)
hold on;
rlocus(G0*Gi)
sgrid(0.18, 50)

pole(feedback(K_dobieno*G0*Gi, 1))

Kp = dcgain(K_dobieno*G0*Gi)

e_stac = 1/(1+Kp)
