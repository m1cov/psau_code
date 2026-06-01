clc
clear

pkg load control


s = tf('s');

G0 = 2/(s+1);

nyquist(G0)
hold on

x = 0:0.01:2*pi;
plot(sin(x), cos(x), 'k-.', 'LineWidth', 2);
hold on;

xt = 0.5;
yt = -0.865;

plot(xt, yt, 'ro', 'LineWidth', 2)
hold on;

line([0, xt], [0, yt], 'color', 'c', 'LineWidth', 2);
hold on;

line([xt, xt], [yt 0], 'color', 'm', 'LineWidth', 2);
line([0 xt], [0 0], 'color', 'm', 'LineWidth', 2);

argG0 = atan2d(yt, xt)

Phir = 180 + argG0
