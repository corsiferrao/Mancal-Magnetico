%% Tratamento de dados do mancal otimziado
% rafael Corsi

% load otimziado dx
load ativo_otimizado_I_dx_03;

i = find(ativo_otimizado_I_dx_03.f <= 0);
plot(ativo_otimizado_I_dx_03.i(1:i), ativo_otimizado_I_dx_03.f(1:i),'Marker','+');
hold on
plot(ativo_otimizado_I_dx_03.i(i:end), ativo_otimizado_I_dx_03.f(i:end),'r','Marker','+');
hold off
ylabel('F [N]');
xlabel('I [A]');

belezura
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx03',1);


%%
load ativo_otimizado_I_dx_00;

figure
plot(ativo_otimizado_I_dx_00.i, ativo_otimizado_I_dx_00.fx,'Marker','+');

ylabel('F [N]');
xlabel('I [A]');

belezura
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx00',1);

%%
fit(ativo_otimizado_I_dx_00.i, ativo_otimizado_I_dx_00.fx, 'poly2')
fit(ativo_otimizado_I_dx_00.i(1:3), ativo_otimizado_I_dx_00.fx(1:3), 'poly1')

%%
fit(ativo_otimizado_I_dx_03.i, ativo_otimizado_I_dx_03.f, 'poly2')
fit(ativo_otimizado_I_dx_03.i(1:3), ativo_otimizado_I_dx_03.f(1:3), 'poly1')

%%
load ativo_otimizado_I_dx_map;

c = 1;
xx =1;
yy =1;

for x = 0:0.05:0.3
    for y = 0:0.5:4
        f(xx,yy) = ativo_otimizado_I_dx_map.f(c);
        c = c+1;
        xx = xx +1;
    end
    yy = yy + 1;
    xx = 1;
end
%%

[X Y] = meshgrid(0:0.05:0.3, 0:0.5:4);
surf(Y,X,f);
colormap(jet)    % change color map
ylabel('dx [mm]');
xlabel('I [A]');
zlabel('F [N]');
title('Force (N) x current (A) x displacment (mm)')

hold off;
%%
figure

plot(ativo_otimizado_I_dx_map.i(1:9),ativo_otimizado_I_dx_map.f(1:9), 'Marker', 'x')
hold on
plot(ativo_otimizado_I_dx_map.i(10:18),ativo_otimizado_I_dx_map.f(10:18), 'Marker', 'o')
plot(ativo_otimizado_I_dx_map.i(19:27),ativo_otimizado_I_dx_map.f(19:27), 'Marker', '.')
plot(ativo_otimizado_I_dx_map.i(28:36),ativo_otimizado_I_dx_map.f(28:36), 'Marker', '*')
plot(ativo_otimizado_I_dx_map.i(37:45),ativo_otimizado_I_dx_map.f(37:45), 'Marker', '^')
plot(ativo_otimizado_I_dx_map.i(46:54),ativo_otimizado_I_dx_map.f(46:54), 'Marker', '>')
plot(ativo_otimizado_I_dx_map.i(55:63),ativo_otimizado_I_dx_map.f(55:63), 'Marker', 's')
hold off;
xlabel('I [A]');
ylabel('F [N]');
legend('d_x=0', 'd_x=0.05', 'd_x=0.1', 'd_x=0.15', 'd_x=0.2', 'd_x=0.25','d_x=0.3')
legend('Location','eastoutside')
belezura
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx_map',1);

