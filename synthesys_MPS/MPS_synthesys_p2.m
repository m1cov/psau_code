clc
clear

Mp = 20.8;
C = (-log(Mp/100))/sqrt(pi^2 + (log(Mp/100))^2)
wn = 2.23

s12 = -C*wn + sqrt(-1)*wn*sqrt(1-C^2)

A = [-5 1 0; 0 -2 1; 0 0 -1]
B = [0 0 1]'
C = [-1 1 0]
D = [0]

sys = ss(A,B,C,D)

[num, den] = ss2tf(A, B, C, D)

G_nc = tf(num, den)

syms s kw1 kw2 kw3

Aw = [0 1 0; 0 0 1; -10 -17 -8];
Bw = [0 0 1]';

kw = [kw1 kw2 kw3];

as = collect((s+1-1j*2)*(s+1+1j*2)*(s+5))

ak = collect(det(s*eye(3) - (Aw - Bw*kw)))

sol = solve(coeffs(ak, s) == coeffs(as, s), [kw1 kw2 kw3]);

kw = double([sol.kw1 sol.kw2 sol.kw3])

%% Proverka za upravlivost
clc

Qcv = ctrb(A, B)

fprintf('Proverka za upravlivost:\n')
if rank(Qcv) == rank(A)
   fprintf('Rangot na Qcv e %d, dimenziite na A se %dx%d => originalniot sistem e kompletno upravliv\n', rank(Qcv), length(A), length(A))
else
    fprintf('Rangot na Qcv e %d, dimenziite na A se %dx%d => originalniot sistem NE e kompletno upravliv\n', rank(Qcv), length(A), length(A))
end

Qcw = ctrb(Aw, Bw)

fprintf('Proverka za upravlivost:\n')
if rank(Qcw) == length(Aw)
   fprintf('Rangot na Qcw e %d, dimenziite na A se %dx%d => transformiraniot sistem e kompletno upravliv\n', rank(Qcv), length(A), length(A))
else
    fprintf('Rangot na Qcw e %d, dimenziite na A se %dx%d => transformiraniot sistem NE e kompletno upravliv\n', rank(Qcv), length(A), length(A))
end

%% Opredeluvanje na P

P = Qcv * inv(Qcw)

kv = kw * inv(P) % se poklopuva so dobienoto k od primer 1!
