%limpa variaveis

clear;
close all;

load comsol_varredura;
load comsol_Fy;

%% Parametros
parametros_magneticos;
parametros_geometricos;

% Variacao
dx = 0;
dy = 0E-3;

m = derivados_geometricos(m, dx, dy);

%% Variação de hef e hm

i=0;
j=1;

for hm=9:1:11
    j=1;
    for hef=5:1:7    
        m.hef = hef*1E-3;
        m.hm  = hm*1E-3;
        m = derivados_geometricos(m, dx, dy);
        res.Fx(i+j,:) = [hm, hef, resolve(m, mag, dx, dy)];
        j=j+1;
    end
    i=j+i-1;
end

%% Varia Dy
dx = 0;
j=1;

for dy=0:0.05E-3:0.2E-3
    m = derivados_geometricos(m, dx, dy);
    [Fx, Fy]  = resolve(m, mag, dx, dy);
    res.Fy(j) =  Fy;
    j=j+1;
end

%% Respostas

res

%comsol_varredura

%% Plot Fx
figure
hold on
    plot(comsol_varredura(:,3,1), 'b')
    plot(res.Fx(:,3,1)-2, 'r')
    legend('EEM', 'Analitico'); 
hold off


%% Plot Fy
figure
hold on
    plot(comsol_Fy(:,1), comsol_Fy(:,2), comsol_Fy(:,1), res.Fy )
    title('Fy')
    legend('EEM', 'Analitico'); 
hold off



