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
export_pdf('Resultados/passivo_otimizado_fem_dx',0);

%% load dy
load fem_otimizado_dy;
fem_otimizado_dy.Fy(5)=-30;
plot(fem_otimizado_dy.dy, fem_otimizado_dy.Fy,'Marker','+');
xlabel('$\Delta_z$ [mm]', 'Interpreter', 'Latex');
ylabel('F_z [N]')
belezura
export_pdf('Eletromagnetica/Resultados/passivo_otimizado_fem_dy',1);


%% load dx e dy

load fem_otimizado_plano;

c = 1;
xx =1;
zz =1;
for x=0:0.5E-3:4E-3
    for z=0:0.5E-3:4E-3
        f(xx,zz) = fem_otimizado_plano.Fx(c);  
        c = c+1;
        zz = zz +1;
    end
    zz=1;
    xx = xx + 1;
end

[X Y] = meshgrid(0:0.5E-3:4E-3,0:0.5E-3:4E-3);

figure1 = figure('PaperType','<custom>','PaperSize',[5 5]);

axes1 = axes('Parent',figure1);
view(axes1,[-67.5 16]);
hold(axes1,'all');
surf(X,Y,f,'Parent',axes1);
xlabel('$\Delta_x  (mm)$', 'Interpreter','Latex')
ylabel('$\Delta_y  (mm)$', 'Interpreter','Latex')
zlabel('$F (N)$', 'Interpreter','Latex')
belezura
export_pdf('Eletromagnetica/Resultados/passivo_otimizado_fem_plano',1);

%%
load fem_otimizado_tilt;
passivo_otimizado_tilt.T(1) = 0;
plot(passivo_otimizado_tilt.tz, passivo_otimizado_tilt.T, 'Marker','+')
xlabel('Tilt em graus');
ylabel('Torque [N.m]'); 
belezura
export_pdf('Eletromagnetica/Resultados/passivo_otimizado_fem_tilt',1);



