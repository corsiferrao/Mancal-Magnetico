function [Fx, Fz] = f_passivo(gx, gz)
% Fev. 2014
% Rafael Corsi Ferrao
% Cálculo do campo B e Força x Distância 
% com campo no ferro saturado do circuito 
% magnético passivo
%
% Adicionado força diferencial

%% Configs

% converte para mm
dx = gx*1E-3;
dz = gz*1E-3;

% comprimento do gap
lg = sqrt(dx.^2+dz.^2);

Hc = 1054E3;    %Hc ima
Br = 1.29;      %Br ima

hfee = 4E-3;    % Altura ferro
wfee = 14E-3;   % Largura do ferro
reei = 61E-3;   % Raio interno ferro
re  = 75E-3;    % Raio externo
wm  = 8E-3;     % Largura imã
Hm  = 10E-3;    % Altura do ima

AS  = 1.08;     % Fator de espraiamento da área

Bfs = 1.6;      % B saturacao ferro
Hfs = 2E4;      % H saturacao ferro
B2  = 1.8;      % B saturacao ferro
H2  = 6E4;      % H saturacao ferro

% Linearizacao da zona saturada
ufs = (B2-Bfs)/(H2-Hfs);

u0 = 4*pi*1E-7; %mu0 

% correcao de nomenclatura
lm = Hm;
lf = wfee;      % linha de campo imã

%% Parametros de área 
Sm = wm*2*pi*(reei+wfee-wm)/2;
Sf = hfee*2*pi*(reei)/2;
Sg = hfee*2*pi*(reei-lg/2)/2*AS;

%% Calculo constantes
C1 = ((Bfs-ufs*Hfs)/(Sm*Br)+1)*Hc*lm;
C2 = 2*(Bfs-ufs*Sf*Hfs)/u0;
C3 = (ufs*Hc*lm)/(Sm*Br)+2*lf;
C4 = 2*(ufs*Sf)/(u0);

%% Ferro

Hf = (C1 - C2*lg/Sg)/(C2+C3*lg/Sg);
Bf = Bfs + ufs*(Hf-Hfs);

%%  Gap

theta =  atand(dz./dx);

Bg = Bf*Sf/Sm;
Bgx = Bg*cosd(theta);
Bgz = Bg*sind(theta);

%% Força

F = 2*Sg/(u0*lg);

Fx = -Bgx^2*F/1E3;
Fz = -Bgz^2*F/1E3;

end