%% Otimização dos parâmetros
% validação do modelo com o de FEM (COMSOL)

clear all;
clc; 

%% load comsol data
load fem_validacao_v0_dx
load fem_validacao_v0_dy
load fem_validacao_v0_rpa

%% Parametros iniciais
parametros_magneticos;
parametros_geometricos;

% Variacao inicial
dx = 0; dy = 0;

%% dx
j  = size(fem_validacao_v0_dx.dx,1);
dy = 0;
for i=1:j 
    rdx.dx(i)  = fem_validacao_v0_dx.dx(i);
    m = derivados_geometricos(m, rdx.dx(i)*1E-3, dy);
    r = resolve_passivo(m, mag, rdx.dx(i)*1E-3, dy);
    rdx.Fx(i) = r.Fx;
end;

figure
hold on
    plot(fem_validacao_v0_dx.dx, abs(fem_validacao_v0_dx.Fx), ...
         rdx.dx, rdx.Fx)
    plot(fem_validacao_v0_dx.dx, abs(fem_validacao_v0_dx.Fx), 'x', ...
         rdx.dx, rdx.Fx, 'o')
hold off
%title('Validação deslocamento em x')
legend('FEM', 'Analitica')
belezura
export_pdf('Resultados/validacao_passivo_dx_offset', 1); 

% calibracao
cal_Fx = sum(fem_validacao_v0_dx.Fx + rdx.Fx')/j

figure
hold on
    plot(fem_validacao_v0_dx.dx, abs(fem_validacao_v0_dx.Fx), ...
         rdx.dx, rdx.Fx-cal_Fx)
    plot(fem_validacao_v0_dx.dx, abs(fem_validacao_v0_dx.Fx), 'x', ...
         rdx.dx, rdx.Fx-cal_Fx, 'o')
hold off
%title('Validação deslocamento em x')
legend('FEM', 'Analitica')
xlabel('Dx [mm]');
ylabel('F [N]'); 
belezura
export_pdf('Resultados/validacao_passivo_dx_calibrado', 1); 


%% dy
j  = size(fem_validacao_v0_dy.dy,1);
i=0;
dx = 0;
for i=1:j 
    rdy.dy(i)  = fem_validacao_v0_dy.dy(i);
    m = derivados_geometricos(m, dx, rdy.dy(i)*1E-3);
    r = resolve_passivo(m, mag, dx, rdy.dy(i)*1E-3);
    rdy.Fy(i) = r.Fy;
end;

fem_validacao_v0_dy.Fy(1) = 0;

figure
hold on
    plot(fem_validacao_v0_dy.dy, abs(fem_validacao_v0_dy.Fy), ...
         rdy.dy, rdy.Fy)
    plot(fem_validacao_v0_dy.dy, abs(fem_validacao_v0_dy.Fy), 'x', ...
         rdy.dy, rdy.Fy, 'o')
hold off
%title('Validação deslocamento em y')
legend('FEM', 'Analitica', 'Location','NorthWest')
xlabel('Dy [mm]');
ylabel('F [N]');
belezura
export_pdf('Resultados/validacao_passivo_dy', 1); 

%% Parametros

parametros_magneticos;

dx = 0; dy = 0;
i=1;

 m.wrr = 9E-3;

for hm=4:2:10
    for wge=1:0.2:1.4
        m.hm  = hm*1E-3;
        m.wge = wge*1E-3;
        m   = derivados_geometricos(m, 0, 0);
        r = resolve_passivo(m, mag, 0, 0);
        rpa(i, :) = [hm 9 wge r.Fx];
        i = i+1;
    end;
end;

figure
hold on;
    plot(1:12, -fem_validacao_v0_rpa(:,4), 'o')
    plot(1:12, rpa(:, 4)-cal_Fx, 'x')
    legend('FEM','Analitica');
    xlabel('Modelo'); 
    ylabel('F [N]');
    belezura
hold off;
export_pdf('Resultados/validacao_passivo_parametros', 1); 

