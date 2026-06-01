clc
clear

s = tf('s');

G0 = 1/(s*(s+3)*(s+5))

rlocus(G0);
sgrid(0.504, 50);

% za ceta = 0.504, dominantniot par na polovi s12 = -0.94 +- j1.61
% pri K = 21.3

K = 21.3

% zd = 0.623

Gd = (s + 0.623)

rlocus(G0 * Gd);
sgrid(0.504, 50);

%% od rlocus za ceta = 0.504 -> Kd = 44.2;

Gd = Gd * 44.2;

pole(feedback(G0*Gd, 1))

step(feedback(G0*Gd, 1))

Gk = zpk(feedback(K*G0, 1))

G0_d = zpk(feedback(G0*Gd, 1))

% bidejkji tretiot pol vo 0.4964 go narushuva povedeniot se aproksimira so
% sistem od vtor red

G_approx = 44.2/(s^2 + 7.504*s + 55.48) % se ponishtuvaat polot vo 0.4964 i nulata vo 0.623

Gk_0 = dcgain(Gk); % Gk(0)
G_approx_0 = dcgain(G_approx); % G_approx(0)

approx_gain = Gk_0/G_approx_0; % Gk(0) = G_approx(0)

G_approx = G_approx * approx_gain

step(Gk);
hold on;
step(G0_d)
hold on;
step(G_approx);
legend('Gk', 'G0 * Gd', 'G_approximated')
hold off;
