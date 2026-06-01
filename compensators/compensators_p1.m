clc
clear

syms s z Zc Pc Zd Pd T Kd

Gd = (s + Zd) / (s + Zc);
Gdz(z) = Kd*(z-Zd)/(z-Pd);

solution = solve(Gd(1)==Gdz(1), Kd);
pretty(solution) % Kd -> statichko zasiluvanje
Kd = solution;


Zd = exp(-Zc * T)
Pd = exp(-Pc * T)

Gd(z) = Kd * (z-Zd)/(z-Pd);
pretty(Gd)


