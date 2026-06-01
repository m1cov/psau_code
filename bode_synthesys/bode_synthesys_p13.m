clc
clear

syms s K
G0 = K/(s*(s+8)*(s+30))

Mp = 10;
Tr = 0.6;

C = (-log(Mp/100))/sqrt(pi^2 + (log(Mp/100))^2) % ceta preku Mp%

Phi_rf = 100*C % Phirf preku ceta

% od Phi_rf zakluchuvame deka arg(G0) ~= -121 deg.

w0 = (2.2/(Tr * C)) * sqrt((1 - 2*C^2) + sqrt(4*C^4 - 4*C^2 + 2)) % propusen opseg preku vreme na porast Tr i ceta

w1 = w0 % se usvojuva w1 <= w0 <= 2*w1, najchesto se zema w1 = 0.8*w0 !

Kv = limit(s*G0, s, 0);

K_sol = double(solve(Kv == 10))

s = tf('s');

K = K_sol;
G0 = K/(s*(s+8)*(s+30));

margin(G0)
grid on;
%% Gdi(s) = Gd(s) * Gi(s) = (s + zd)/(s + pd) * (s + zi)/(s + pi)
clc

Phirf_wanted = Phi_rf;
Phirf_current = 180 - 146; % 180 - arg[G0(w1)] -> arg(G0(w1)) = -146 -> se bara preku novoto w1 dobieno od w0
corr_factor = 12; % od 5 do 12

Phimax = Phirf_wanted - Phirf_current + corr_factor;

B = (1 - sind(Phimax))/(1 + sind(Phimax))
Y = 1/B

% prvo se proektira Gi(s)
zi = w1/10;
pi = zi/Y;

Gi = (1/Y) * (s + zi)/(s + pi);

% se proektira Gd(s)
zd = w1 * sqrt(1/Y);
pd = zd * Y;

Gd = Y * (s+zd)/(s+pd);

Gid = Gi * Gd;

bode(G0, G0*Gid, Gid)
legend('G0_{nc}', 'G0*Gid', 'Gid')
grid on;

%% proverka

Kv = dcgain(s*G0*Gid)
step(feedback(G0, 1), feedback(G0*Gid, 1))

% paramtetar | proektno baranje | realizirano
%     Kv              10               10
%     Mp              10%              8.38%
%     Tp              0.6s             0.527s
