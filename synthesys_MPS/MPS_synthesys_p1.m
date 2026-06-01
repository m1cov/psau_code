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

syms s k1 k2 k3

as = collect((s+1-1j*2)*(s+1+1j*2)*(s+5)) % se dodava tret pol 5 do 10 pati polevo od ostanatite za da ima pomalo vlijanie

ak = collect(det([s+5 -1 0; 0 s+2 -1; k1 k2 s+1+k3]))

sol = solve(coeffs(ak, s) == coeffs(as, s), [k1 k2 k3]);

%% Sporedba na odzivi
clc

k = double([sol.k1 sol.k2 sol.k3])
A_c = A - B*k

[num_c, den_c] = ss2tf(A_c, B, C, D)

G_c = tf(num_c, den_c)

pole(G_c)

step(G_nc)
hold on;
step(G_c)
legend('Nekompenziran', 'Kompenziran')
