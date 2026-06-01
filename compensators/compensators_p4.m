clc
clear

s = tf('s');

P = 200/((s+2)*(s+4)*(s+5))

Gd1 = (s+3)/(s+30);
Gd2 = (s+0.3)/(s+30);

margin (feedback(P, 1));
hold on;

% bez kompenzator -> w0 = 7.17 rad/s

margin(feedback(Gd1 * P, 1));
hold on;

% so Gd1 -> w0 = 3.38 rad/s

margin(feedback(Gd2 * P, 1));

% so Gd2 -> w0 = 12.8 rad/s

grid on;
legend('Gnc', 'Gd1', 'Gd2');

% za Gd1:

z_p1 = 3/30

% za Gd2:

z_p2 = 0.3/30

% so namaluvanje na soodnosot z/p na dif. komp., se zgolemuva propusniot
% opseg na sistemot

P_bw = bandwidth(feedback(P, 1))
P_Gd1_bw = bandwidth(feedback(Gd1 * P, 1))
P_Gd2_bw = bandwidth(feedback(Gd2 * P, 1))
