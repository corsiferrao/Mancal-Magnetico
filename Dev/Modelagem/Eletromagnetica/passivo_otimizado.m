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
ylabel('F_x [N]')
export_pdf('Resultados/passivo_otimizado_fem_dx',1);

%% load dy
load fem_otimizado_dy;
fem_otimizado_dy.Fy(5)=-30;
plot(fem_otimizado_dy.dy, fem_otimizado_dy.Fy,'Marker','+');
xlabel('d_y [mm]');
ylabel('F_y [N]')
belezura
export_pdf('Resultados/passivo_otimizado_fem_dy',1);


%% load dx e dy

load fem_otimizado_plano;

c = 1;
xx =1;
zz =1;
for x=0:0.5:4
    for z=0:0.5:4
        f(xx,zz) = fem_otimizado_plano.Fx(c);  
        c = c+1;
        zz = zz +1;
    end
    zz=1;
    xx = xx + 1;
end

[X Y] = meshgrid(0:0.5:4,0:0.5:4);
surf(X,Y,f);

export_pdf('Resultados/passivo_otimizado_fem_palno',1);
