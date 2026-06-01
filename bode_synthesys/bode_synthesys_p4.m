clc
clear

s = tf('s');

% Phi_rf = 180 + arg(G0) = 45 stepeni => arg(G0) = -135 stepeni.
% 20*log10(K) = 35.5 => K = 10^(35.5/20)

% uslovot e ispolnet za maskimalna vrednost na K = 60.5

K = 60.5;
G0 = K/(s*(s+5)^2)

margin(G0);
grid on;


