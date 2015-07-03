%% Tratamento de dados do mancal otimziado
% rafael Corsi

% load otimziado dx
load('fem_otimizado_dx.mat')

figure
    plot(fem_otimzado_dx(:,1),fem_otimzado_dx(:,2), 'o');
hold on
    plot(fem_otimzado_dx(:,1),fem_otimzado_dx(:,2));
hold off
belezura
xlabel('d_x [mm]');
ylabel('F_x [N])')
export_pdf('Resultados/passivo_otimizado_dx',1);

%% load dx e dy

load fem_otimizado_dx_dy_fx_fy;

ix = find(fem_otimizado_dx_dy.dx ==0);
iy = find(fem_otimizado_dx_dy.dy ==0);

plot(fem_otimizado_dx_dy.dy(1:18:end),fem_otimizado_dx_dy.Fy(1:18:end));