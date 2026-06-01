clc
clear

z = tf('z', 1);

K = [1, 0.01, 0.05, 0.1, 0.5, 10, 50];


for i=1:1:length(K)
    G0 = (K(i)*(z+1)^3)/((z-1)*(z+0.25)*(z+0.6));
    nyquist(G0);
    hold on;
end
legend('K = 1', 'K = 0.01', 'K = 0.05', 'K = 0.1', 'K = 0.5', 'K = 10', 'K = 50')


