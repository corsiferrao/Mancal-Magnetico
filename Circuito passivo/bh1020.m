%% BH - ACO 1020
% http://www.fieldp.com/magneticproperties.html
Mo = 4*pi*1E-7;
H = B./(Mu*Mo);
plot(H(1:25),B(1:25))
xlabel('H')
ylabel('B')
belezura