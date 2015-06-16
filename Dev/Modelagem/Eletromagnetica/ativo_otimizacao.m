%% Otimização dos parâmetros
% Etapas : 
%   a. definir funcional
%   b. definir parametros e range e stap
%   c. realizar interações
%
% usando o método Simplex (sem derivadas) para otimizar
%
% a. Funcional 
%   - Fx >>
%               Queremos uma força de atração Fx na maior excursão
%
%   - L  <<
%               Queremos uma indutancia pequena
%
%   - Volume_m  <<
%               Queremos um volume menor -> menor peso
%

clear all;
clc; 
%%
% variáveis globais para armazenamento dos valores intermediaários
global Fx;
global Lmain;
global V;
global Im;
global in;

% versao da funcao merito a ser utilizada
global version;

% carrega valore iniciais
parametros_geometricos;

%  [wgi     nnb     hnb     lnb    wei      rnb
V0=[0.6E-3  300     10E-3   22E-3  6E-3     12E-3];
LO=[0.4E-3  50      5E-3    10E-3  3E-3     6E-3];
UB=[1.2E-3  600     20E-3   30E-3  10E-3    22E-3];

% corrente aplicada a bobina
Im = 4;

po = V0;

% configura otimizacao
options = optimset( 'Display', 'iter',  ...
                   'TolX',0.1,'TolFun',0.1, ...
                   'MaxIter', inf);

% contador para armazenameto dos resultados
in = 1;

%% Executa otimizaçãocl

%define funcao merito
version = 1;        

% executa otmizacao
[x,fval] = fminsearchbnd('funcional_ativo', po, LO, UB, options);


%% Resultados
figure
h1 = subplot(2,1,1); 

subplot(3,1,1); 
    plot(1:in-1, Fx,'o'); 
    title('F_x');
    belezura;
subplot(3,1,2); 
    plot(1:in-1, Lmain,'o');
    title('L');
    belezura;
subplot(3,1,3); 
    plot(1:in-1, V,'o');
    title('Volume');
    belezura;
    
export_pdf('Resultados/otimizacao_ativo_parametros',1);
    
%% pesos funcionais
% 
[F, P1, P2, P3, P4 ] = merito( Fx, L, V, dBef, m, version );

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

export_pdf('Resultados/otimizacao_passivo_pesos',1);

