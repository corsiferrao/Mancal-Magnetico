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

%addpath('APIs')
%addpath('APIs')


clear all;
clc; 

% variáveis globais para armazenamento dos vlaores intermediaários
global in;
global Fx;
global Fy;
global V;
global dBef;

% versao da funcao merito a ser utilizada
global version;

% carrega valore iniciais
parametros_geometricos;

%  [m.hef   m.wef   m.wm    m.hm    m.wge   m.wrf   m.wrr   m.ree  ];
V0=[6E-3    14E-3   8E-3    10E-3   1.2E-3  10E-3   6E-3    75E-3];
LO=[2E-3    7E-3    4E-3    5E-3    1.0E-3  5E-3    3E-3    50E-3];
UB=[10E-3   21E-3   12E-3   15E-3   3.0E-3  15E-3   9E-3    80E-3];
po = V0;

% configura otimizacao
options = optimset( 'Display', 'iter',  ...
                   'TolX',0.1,'TolFun',0.1, ...
                   'MaxIter', inf);

% contador para armazenameto dos resultados
in = 1;

%% Executa otimização

%define funcao merito
version = 4;        

% executa otmizacao
[x,fval] = fminsearchbnd('funcional', po, LO, UB, options);


%% Resultados
figure
h1 = subplot(2,1,1); 

subplot(2,2,1); 
    plot(1:in-1, Fx,'o'); 
    title('Fx');
subplot(2,2,2); 
    plot(1:in-1, Fy,'o');
    title('Fy');
subplot(2,2,3); 
    plot(1:in-1, V,'o');
    title('Volume');
subplot(2,2,4); 
    plot(1:in-1, dBef,'o');
    title('Bef');
    
%% pesos funcionais

[F, P1, P2, P3, P4 ] = merito( Fx, Fy, V, dBef, m, version );

figure
    plot(P1)
hold on
    plot(P2, 'r')
    plot(P3, 'g')
    plot(P4, 'c')
    plot(F,  'm')
title('pesos');
legend('P1', 'P2', 'P3', 'P4', 'F'); 
belezura
