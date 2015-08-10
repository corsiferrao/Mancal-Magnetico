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
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx03',0);


%% 
load ativo_otimizado_I_dx_00;

figure
plot(ativo_otimizado_I_dx_00.i, ativo_otimizado_I_dx_00.fx,'Marker','+');

ylabel('F [N]');
xlabel('I [A]');

belezura
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx00',0);

%% Forca ativo segunda ordem 
fit(ativo_otimizado_I_dx_00.i, ativo_otimizado_I_dx_00.fx, 'poly2')
fit(ativo_otimizado_I_dx_00.i(1:3), ativo_otimizado_I_dx_00.fx(1:3), 'poly1')

%% Forca ativo primeira ordem
fit(ativo_otimizado_I_dx_03.i, ativo_otimizado_I_dx_03.f, 'poly2')
fit(ativo_otimizado_I_dx_03.i(1:3), ativo_otimizado_I_dx_03.f(1:3), 'poly1')

%% Indutânci
load ativo_otimizado_B_polos;

figure
plot(ativo_otimizado_B_polos.dx, ativo_otimizado_B_polos.Bp, ...
    'Marker', 'o');
xlabel('Dx [mm]');
ylabel('B [T]');
belezura

export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_B_polos',0);

figure
plot(ativo_otimizado_B_polos.dx, ativo_otimizado_B_polos.Bs, ...
    'Marker', '>');
xlabel('Dx [mm]');
ylabel('B [T]');
belezura 

export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_B_polos',0);

%% Calculo da indutância

S = 196.7E-6; % [m2]
I = ativo_otimizado_B_polos.i(1);
L = ativo_otimizado_B_polos.Bp*S/I
M = ativo_otimizado_B_polos.Bs*S/I


[c g] = fit(ativo_otimizado_B_polos.dx, L,  'poly1')
[c g] = fit(ativo_otimizado_B_polos.dx, M,  'poly1')



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


figure
[X Y] = meshgrid(0:0.05:0.3, 0:0.5:4);
surf(Y,X,f);
colormap(jet)    % change color map
ylabel('dx [mm]');
xlabel('I [A]');
zlabel('F [N]');
title('Force (N) x current (A) x displacment (mm)')
belezura 

%% fit

fit([X,Y],f,'poly23')

Fp_model =  fit([ativo_otimizado_I_dx_map.dx,ativo_otimizado_I_dx_map.i],ativo_otimizado_I_dx_map.f, 'poly23' )

%% Força por deslocamento
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
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx_map',0);

%% Só corrente
load  ativo_otimizado_I_mapa_corrente;

c = 1;
xx =1;
yy =1;

for x = 0:0.1:0.3
    for y = 0:0.5:4
        f(xx,yy) = -ativo_otimizado_I_mapa_corrente.f(c);
        c = c+1;
        xx = xx +1;
    end
    yy = yy + 1;
    xx = 1;
end


figure
[X Y] = meshgrid(0:0.1:0.3, 0:0.5:4);
surf(Y,X,f);
colormap(jet)    % change color map
ylabel('dx [mm]');
xlabel('I [A]');
zlabel('F [N]');
title('Force (N) x current (A) x displacment (mm)')
belezura 

%% fit ponto de operação
fitt = fit(ativo_otimizado_I_mapa_corrente.f(1:9), ativo_otimizado_I_mapa_corrente.i(1:9), 'poly1' )
%% fit 3d

% Set up fittype and options.
ft = fittype( 'poly11' );
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf -Inf];
opts.Robust = 'Bisquare';
opts.Upper = [Inf Inf Inf];

[xData, yData, zData] = prepareSurfaceData(  X(1:5,:),  Y(1:5,:), f(1:5,:));


% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'untitled fit 1', 'f vs. X, Y', 'Location', 'NorthEast' );
% Label axes
xlabel( 'X' );
ylabel( 'Y' );
zlabel( 'f' );
grid on
view( -85.5, 54.0 );