clc
clear

syms s z Pc Pd Zc Zd Kd T

Gi(s) = Pc / Zc * (s + Zc) / (s + Pc);
Giz(z) = (1 - Pd) / (1 - Zd) * (z - Zd) / (z - Pd);

Zd = exp(-Zc * T);
Pd = exp(-Zc * T);

Gi(z) = (1-Pd)/(1-Zd) * (z-Zd)/(z-Pd);
pretty(Gi);
