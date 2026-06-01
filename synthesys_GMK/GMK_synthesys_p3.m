clc
clear

s = tf('s');

G0 = 1/(s*(s^2 + 2*s + 5))

rlocus(G0) % sleduva deka pri a = 10 sistemot e na gr. na stabilnost
