%% Calcula forcas do circuito passivo do mancal

%% Inicializacao
% exporta os dados ?
global exportar;
exportar = 0;

% Carrega parametros
parametros;

%% deslocamentos
x = -0.3:0.05:0.3;
y = -0.3:0.05:0.3;
z = zeros(1,size(x,2));

xx = 1;
yy = 1;
kk = 1;
for i=1:size(x,2) 
    for j=1:size(y,2)
        % transforma deslocamento em gaps
        
        lg.n  = sqrt((1.2 - y(j))^2 + z(i)^2);
        lg.o  = sqrt((1.2 + x(i))^2 + z(i)^2);
        lg.l  = sqrt((1.2 - x(i))^2 + z(i)^2);
        lg.s  = sqrt((1.2 + y(j))^2 + z(i)^2);        
        
        % forca em xf
        f.n  = f_passivo(lg.n , z(kk));
        f.o  = f_passivo(lg.o , z(kk));
        f.s  = f_passivo(lg.s , z(kk)); 
        f.l  = f_passivo(lg.l , z(kk)); 

        fx(xx,yy)  = -f.l + f.o ;
        fy(xx,yy)  = -f.n + f.s ;
        
        yy = yy + 1;
    end
    
    xx = xx + 1;
    yy = 1;    
end

%%
figure
 surfc(x,y,sqrt(fx.^2+fy.^2))
 xlabel('\Delta_x (mm)'); 
 ylabel('\Delta_y (mm)');
 belezura

 %%
figure
  plot(x,fx, 'b');
  xlabel('\Delta_x (mm)'); 
  ylabel('Fx (N)'); 
  belezura

%% Dz
% deslocamentos

x = 0;
y = 0;
z = 0:0.01:0.4;

zz = 1;
for i=1:size(z,2)
    
    lg.n  = sqrt((1.2 - y)^2 + z(i)^2);
    lg.o  = sqrt((1.2 + x)^2 + z(i)^2);
    lg.l  = sqrt((1.2 - x)^2 + z(i)^2);
    lg.s  = sqrt((1.2 + y)^2 + z(i)^2);
    
    %forca em xf
    [dum f.zn]  = f_passivo(lg.n, z(i));
    [dum f.zo]  = f_passivo(lg.o, z(i));
    [dum f.zs]  = f_passivo(lg.s, z(i));
    [dum f.zl]  = f_passivo(lg.l, z(i));
    
    fz(zz)  = +f.zl + f.zo + f.zs + f.zn ;
    
    zz = zz + 1;
end


figure
hold on;
  plot(z,-fz, 'b'); 
  plot(z,-fz, '.');
  xlabel('\Delta_z (mm)'); 
  ylabel('F (N)'); 
belezura
hold off;
 
%% Comsol dx
comsol_fx = [0.61214 57.16536 110.9668 165.28637];
comsol_dx = 0:0.1:0.3
figure
    hold on
    plot(comsol_dx,comsol_fx);
    plot(comsol_dx,comsol_fx, '.');
    xlabel('\Delta_x (mm)');
    ylabel('F (N)'); 
    belezura
    
% save figure
set(gcf, 'PaperPosition', [0 0 5 5]); 
set(gcf, 'PaperSize', [5 5]); 
saveas(gcf, 'test', 'pdf') %Save figure

%% Comsol dy
comsol_fy =[0.11564 -43.93489 -71.09197 -78.83586 -78.11995 -62.53365]
comsol_dy =[0 0.2 0.4 0.6 0.8 1]	

figure
    hold on
    plot(comsol_dy(1:4),comsol_fy(1:4));
    plot(comsol_dy(1:4),comsol_fy(1:4), '.');
    xlabel('\Delta_y (mm)');
    ylabel('F (N)'); 
    belezura

export_pdf('forca:passivo:comsol:dy');

%% Comsol vs analitico

   
  

