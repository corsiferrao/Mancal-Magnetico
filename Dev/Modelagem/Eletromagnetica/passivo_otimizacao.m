%% Otimização dos parâmetros
% Etapas : 
%   a. definir funcional
%   b. definir parametros e range e stap
%   c. realizar interações
%
% usando o método Simplex (sem derivadas) para otimizar
%
% a. Funcional 
%   - Fy > Fx 
%               Previlegiamos a forca em Y do que em X
%
%   - Bfe(gap=x) = Bfe(gap=x+0.6)
%               Queremos que a força em dx seja + linear
%
%   - Volume_m  <<
%               Queremos um volume menor -> menor peso
%

clear all;
clc; 

% variáveis globais para armazenamento dos vlaores intermediaários
global in;
global Fx;
global Fy;
global V;
global Gap;
global Raio;
global dBef;

% versao da funcao merito a ser utilizada
global version;

% carrega valore iniciais
parametros_geometricos;

%  [m.hef   Dwef    m.wm    m.hm    m.wge   Dwrf   m.wrr   m.ree ];
V0=[6E-3    4E-3    8E-3    10E-3   3.0E-3  4E-3   6E-3    75E-3 ];
LO=[2E-3    2E-3    4E-3    5E-3    1.0E-3  2E-3   3E-3    50E-3 ];
UB=[10E-3   6E-3    12E-3   15E-3   3.0E-3  8E-3   9E-3    80E-3 ];
po = V0;

% configura otimizacao
options = optimset( 'Display', 'iter',  ...
                   'TolX',0.1,'TolFun',0.1, ...
                   'MaxIter', inf);

% contador para armazenameto dos resultados
in = 1;

%% Executa otimização

%define funcao merito
version = 5;        

% executa otmizacao
[x,fval] = fminsearchbnd('funcional_passivo', po, LO, UB, options);


%% Resultados
figure
h1 = subplot(3,2,1); 

subplot(3,2,1); 
    plot(1:in-1, Fx,'o'); 
    title('$$F_x$$', 'Interpreter','latex');
    belezura;
subplot(3,2,2); 
    plot(1:in-1, Fy,'o');
    title('$$F_y$$', 'Interpreter','latex');
    belezura;
subplot(3,2,3); 
    plot(1:in-1, V,'o');
    title('$$V_m$$', 'Interpreter','latex');
    belezura;
subplot(3,2,4); 
    plot(1:in-1, dBef, 'o ');
    title('$$\Delta B_{ef}$$', 'Interpreter','latex');
    belezura;
subplot(3,2,5); 
    plot(1:in-1, Raio, 'o ');
    title('$$r_{eei}$$', 'Interpreter','latex');
    belezura;
subplot(3,2,6); 
    plot(1:in-1, Gap, 'o ');
    title('$$w_g$$', 'Interpreter','latex');
    belezura;
    
export_pdf('Resultados/otimizacao_passivo_parametros',1);
    
%% pesos funcionais

[F, P1, P2, P3, P4, P5, P6 ] = merito_passivo( Fx, Fy, V, dBef, m, Gap, Raio, version );

figure
    plot(P1)
hold on
    plot(P2, 'r')
    plot(P3, 'g')
    plot(P4, 'y')
    plot(P5, 'c')
    plot(P6, 'k')
    plot(F,  'p')
title('pesos');
legend('P1', 'P2', 'P3', 'P4', 'P5', 'P6', 'F', 'Location','EastOutside'); 
belezura

export_pdf('Resultados/otimizacao_passivo_pesos',1);

%% Salva resultados encontrados

hef = x(1);
wef_delta = x(2);
wm  = x(3);
wef = wm+wef_delta;
hm  = x(4);
wge = x(5);
wrr = x(7);
wrf_delta = x(6);
wrf = wrr + wrf_delta;
ree = x(8);

save('resultados_otimizacao_passivo','hef','wef','wm','hm','wge','wrf','wrr','ree');

%% comsol 



