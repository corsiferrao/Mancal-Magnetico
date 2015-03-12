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
%   - Bfe(gap=x) = Bfe(gap=x+0.6)
%               Queremos que a força seja + linear
%   - Volume_m  <<
%               Queremos um volume pequeno -> menor peso

clear all;
clc; 
global m; global mag;

parametros_magneticos;
parametros_geometricos;


po=[m.hef m.wef m.wm m.hm m.wge m.wrf m.wrr m.ree];

%merito1(po);


options = optimset('Display','iter','TolX',1e-4,'TolFun',1e-4);

[x,fval] = fminsearch('merito1', po ,options);
