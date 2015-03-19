% Rafael Corsi
% Mancal magnético - Dissertação de Mestrado
% 10.4.14
%
% Resumo :
%  Analise dos resultados
% modelo bom para região sem saturação e ruim para correntes
% com mais de 1 A

%% exporta os dados ?
global exportar;
exportar = 1;

%% comsol data
Co = [
0   0;
1	55.17407;
2	154.03054;
3	235.62098;
4	301.16948]; 

C.I  = Co(:,1);
C.Fx = Co(:,2);

load comsol_0_2A;

%% no pnt de equilibrio
g = 0.6E-3;
i = 0:0.1:4; %grafico
j = 0;

for i=0:0.1:4
   j = j+1;
   [Fx(j), Fy(j), Bfn(j)] = f_ativo(i/2,i,i/2,g,g,g);
   I(j) = i;
end

ibsat = find(Bfn>=1.2,1);

%%
figure
  hold on
  plot(I(1:ibsat), Bfn(1:ibsat));
  plot(I(ibsat:end), Bfn(ibsat:end), 'r' );

  plot(I(1:ibsat), Bfn(1:ibsat), '.');
  plot(I(ibsat:end), Bfn(ibsat:end), ['.', 'r'] );

  xlabel('Corrente (A)');
  ylabel('B (T)');
  belezura
  export_pdf('Bxfn:ativo:modelagem:eq');

%%
figure
  hold on
  plot(I(1:ibsat), Fx(1:ibsat));
  plot(I(ibsat:end), Fx(ibsat:end), 'r' );

  plot(I(1:ibsat), Fx(1:ibsat), '.');
  plot(I(ibsat:end), Fx(ibsat:end), ['.', 'r'] );

  xlabel('Corrente (A)');
  ylabel('Forca (N)');
  belezura
export_pdf('Fx:ativo:modelagem:eq');


%% Comsol Fx
figure
  hold on
  plot(C.I, C.Fx);
  plot(C.I, C.Fx, '.');

  xlabel('Corrente (A)');
  ylabel('Forca (N)');
  belezura
export_pdf('Fx:ativo:comsol:eq');

%% Comparativo
figure

aux = find(C.I == 2);

  hold on
  plot([comsol_0_2A.i; C.I(aux:end)], [comsol_0_2A.Fx; C.Fx(aux:end)], '-o', ...
      'markersize', 2);
  plot(I, Fx, '-or', 'markersize', 2);

  xlabel('Corrente (A)');
  ylabel('Forca (N)');
  belezura
  
legend('FEM', 'Analitica', 'Location',  'NorthWest');
export_pdf('Forca:ativo:comparacao:eq');

%% Comparativo até B=1.2

figure
  hold on
  plot(C.I(1:3), C.Fx(1:3));
  plot(I(1:ibsat), Fx(1:ibsat), 'r');

  xlabel('Corrente (A)');
  ylabel('Forca (N)');
  belezura
export_pdf('Fx:ativo:comparacao:nsaturado:eq');

%% Curva B-H
load B_H

aux = find(B>=1.2,1);

figure
  hold on
  plot(H(1:aux), B(1:aux));

  ylabel('B (T)');
  xlabel('H (A/m)');
  belezura
export_pdf('Curva:B:H:nsaturado');

%% Zoom Comosol 0-2A

%fit
 %fx = 27.5850*i

figure
  hold on
  plot( comsol_0_2A.i,  comsol_0_2A.Fx, '-o', ...
                                        'MarkerSize',2);
  plot([0 2], [0 55.17*2]*2/3, 'r');          
                                    
  legend('FEM', 'Linearizacao', 'Location',  'NorthWest');
  xlabel('Corrente (A)');
  ylabel('Forca (N)');
  belezura
  
export_pdf('Forca:ativo:comsol:0:2A:eq');

%% comsol corrente vs x dx vs forca
load fx
f = [fx(1:5) fx(6:10) fx(11:15) fx(16:end)]
x = 0:0.1:0.3
y = 0:0.25:1

% Fit
m = fx(1:5)'/y;

surf(x,y,f)

  xlabel('Dx (mm)');
  ylabel('Corrente (A)');
  zlabel('Fx (N)'); 
  
figure
plot(y,fx(1:5))
hold on
plot(y,y*m, 'o')
  belezura
  
%%
figure
  hold on
  plot( comsol_0_2A.i,  comsol_0_2A.Fx, '-o', ...
                                        'MarkerSize',2);


plot(C.I(3:end), C.Fx(3:end),  '-o',  'MarkerSize',2)
xlabel('Corrente (A)');
  ylabel('Forca (N)');
xlabel('Current (A)');
ylabel('Force (N)');
belezura
export_pdf('Forca:ativo:artigo');


%% Fit
%  p00 =    -0.06052  
%  p10 =      -32.76 
%  p01 =       41.32  
%  f(x,y) = p00 + p10*x + p01*y
%       

  