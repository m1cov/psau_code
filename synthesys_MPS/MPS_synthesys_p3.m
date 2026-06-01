clc
clear

syms s

as = collect((s+1)^2 * (s+2))
aso = collect((s+1*10)^2 * (s+2*10))

A = [0 1 0; 0 0 1; -4 -6 -4];
B = [0 0 1]';
C = [1 0 1];
D = 0;

% Opredeluvanje na zasiluvanja na sistemot {matrica K}
syms s k1 k2 k3

K = [k1 k2 k3]

ak = collect(det(s*eye(3) - (A - B*K)))

sol = solve(coeffs(ak, s) == coeffs(as, s), [k1 k2 k3]);

K = double([sol.k1 sol.k2 sol.k3])

% Opredeluvanje na zasiluvanja na observerot {matrica L}
Aw = A.';
Bw = C.';
Cw = B.';
Dw = D;

syms Lw1 Lw2 Lw3

Lw = [Lw1 Lw2 Lw3].';

aLw = collect(det(s*eye(3) - (Aw - Lw*Cw)))

sol = solve(coeffs(aLw, s) == coeffs(aso, s), [Lw1 Lw2 Lw3]);

Lw = double([sol.Lw1 sol.Lw2 sol.Lw3])'

%% Proverka za nabljudlivost
clc

Qov = obsv(A, C)

fprintf('Proverka za nabljudlivost:\n')
if rank(Qov) == rank(A)
   fprintf('Rangot na Qcv e %d, dimenziite na A se %dx%d => originalniot sistem e kompletno nabljudliv\n', rank(Qov), length(A), length(A))
else
    fprintf('Rangot na Qcv e %d, dimenziite na A se %dx%d => originalniot sistem NE e kompletno nabljudliv\n', rank(Qov), length(A), length(A))
end

Qow = obsv(Aw, Cw)

fprintf('Proverka za nabljudlivost:\n')
if rank(Qow) == length(Aw)
   fprintf('Rangot na Qcw e %d, dimenziite na A se %dx%d => transformiraniot sistem e kompletno nabljudliv\n', rank(Qow), length(A), length(A))
else
    fprintf('Rangot na Qcw e %d, dimenziite na A se %dx%d => transformiraniot sistem NE e kompletno nabljudliv\n', rank(Qow), length(A), length(A))
end

%% Opredeluvanje na P

P = inv(Qov) * Qow

Lv = P * Lw

K = [-2 -1 0];

polovi_observer = eig(A - Lv*C)
polovi_sistem = eig(A - B*K)
