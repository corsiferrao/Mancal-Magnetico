function [Fx, Fz] = f_passivo(gx, gz)
% Fev. 2014
% Rafael Corsi Ferrao
% Cálculo do campo B e Força x Distância 
% com campo no ferro saturado do circuito 
% magnético passivo
%
% Adicionado força diferencial

%% Configs

parametros
As = 1.2;

% converte para mm
dx = gx*1E-3;
dz = gz*1E-3;

% comprimento do gap
lg = sqrt(dx.^2+dz.^2);

%% Parametros de área 
Sm = wm*2*pi*(reei+wfee-wm)/frac;
Sf = hfee*2*pi*(reei)/frac;
Sg = Sf;
Sg = (hfee*2*pi*(reei-lg/2)/frac)*AS;

%% Novas constantes
C1 = -ufs*Sf*Hc*lm/(Sm*Br)+2*lf;
C2 = 2*ufs*Sf/u0;
C3 = -(ufs*Hfs*Sf/Sm+Br-Bfs)*Hc*lm/Br;
C4 = -2*(Bfs*Sf-ufs*Sf*Hfs)/u0;

%% Ferro
Hf = (C3 + C4*lg/Sg)/(C1+C2*lg/Sg);
Bf = Bfs + ufs*(Hf-Hfs);

%%  Gap
theta = atand(dz./dx);

%% porque tenho que dividir o campo por 2 ? tem alguma coisa errada !
%   - pode ser por causa do ferro do retorno ! ?
%   - verificar se estou fazendo a conta certa no main.
Bg  = Bf*Sf/Sg/2;
Bgx = Bg*cosd(theta);
Bgz = Bg*sind(theta);

%% Força, e aqui por 2 ?
Fx = (Bgx^2*Sg)/(u0*2);
Fz = (Bgz^2*Sg)/(u0*2)*frac; 

end