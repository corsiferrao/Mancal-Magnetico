%% forca resultante em x

reei = 61E-3;   % Raio interno ferro
rre  = 59.8E-3; % raio rotor externo

%% deslocado em 0.1 mm para esquerda
x = [0.1 0.2 0.3];
y = 0;

lg_n  = 1.2 - y;
lg_o  = 1.2 - x;

lg_l  = 1.2 + x;
lg_s  = 1.2 + y;

lg_oo = 1.2 - sqrt(x.^2+y.^2);
lg_ll = 1.2 + sqrt(x.^2+y.^2);

alf_oo = atan(lg_n./lg_oo);
alf_ll = atan(lg_n./lg_ll);

for i =1:3
    fx_p = f_passivo(lg_o(i),0) + 2*cos(alf_oo(i))*f_passivo(lg_oo(i),0);
    fx_n = f_passivo(lg_l(i),0) + 2*cos(alf_ll(i))*f_passivo(lg_ll(i),0);
    fx(i) = (fx_p - fx_n);    
end

c.x  = [0.1 0.2 0.3];
c.y = [57.49347 110.84299 160.59358];


figure
plot(c.x, c.y, 'r');
    hold on
plot(c.x,-fx, 'b')
legend('Comsol', 'Analitico')
plot(c.x, c.y, 'x');
plot(c.x,-fx, 'x')

