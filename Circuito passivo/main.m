%% forca resultante em x

% deslocamentos
x = [-0.3:0.1:0.3];
y = [-0.3:0.1:0.3];

%% transforma deslocamento em gaps
lg_n  = 1.2 - y;
lg_o  = 1.2 - x;

lg_l  = 1.2 + x;
lg_s  = 1.2 + y;

lg_oo = 1.2 - sqrt(x.^2+y.^2);
lg_ll = 1.2 + sqrt(x.^2+y.^2);

% angulos
alf_oo = atan(lg_n./lg_oo);
alf_ll = atan(lg_n./lg_ll);


%% Deslocamento puramente radial
for i =1:size(x,2)
    fx_p = f_passivo(lg_o(i),0) + 2*cos(alf_oo(i))*f_passivo(lg_oo(i),0);
    fx_n = f_passivo(lg_l(i),0) + 2*cos(alf_ll(i))*f_passivo(lg_ll(i),0);
    a.fx(i) = (fx_p - fx_n);    
end

%% Deslocamento puramente axial
for i =1:size(y,2)
    [~, a.fy(i)] = f_passivo(1.2, y(i));
end

%% Comsol
% forca comsol radial
c.x  = [0 0.1 0.2 0.3];
c.fx  = [0.61214 57.49347 110.84299 165.28637];

% fit comsol x
%fitcomsolx = fit(c.x',c.fx','linearinterp');
%c.fx = fitcomsolx(x);

% forca comsol axial
c.y  = [0 0.1 0.2 0.3];
c.fy = [-4.755 -28.4079 -42.57 -53.90];

%fitcomsoly = fit(c.y',c.fy','linearinterp');
%c.fy = fitcomsoly(y);

%% plota Fx - Radial
figure; hold on
plot(x, c.fx, 'r');
plot(x, c.fx, 'x');
plot(x,-a.fx, 'b')
plot(x,-a.fx, 'x')
legend('FEM', 'Analitico')
xlabel('Deslocamento (mm)')
ylabel('Força (N)')
belezura

%% plota Fy - Axial
figure; hold on
plot(x, c.fy, 'r');
plot(x, c.fy, 'x');
plot(x,-a.fy, 'b')
plot(x,-a.fy, 'x')
legend('FEM', 'Analitico')
xlabel('Deslocamento (mm)')
ylabel('Força (N)')
belezura