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

%%
% comprimento do gap
lg = sqrt(dx.^2+dz.^2);

Hc = 1054E3;    %Hc ima
Br = 1.29;      %Br ima

hfee = 0.004;   % Altura ferro
wfee = 0.0148;  % Largura do ferro estator externo
re   = 0.0758;  % Raio externo
reei = re-wfee; % Raio interno ferro estator externo
wm   = 0.008;   % Largura imã
Hm   = 0.010;   % Altura do ima

AS  = 1.0;     % Fator de espraiamento da área

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
Sm = wm*2*pi*(reei+wfee-wm)/8;
Sf = hfee*2*pi*(reei)/8;
Sg = Sf;
Sg = hfee*2*pi*(reei-lg/2)/8*AS;


%% Novas constantes
C1 = -ufs*Sf*Hc*lm/(Sm*Hm)+2*lf;
C2 = 2*ufs*Sf/u0;
C3 = -(ufs*Hfs*Sf/Sm+Br-Bfs)*Hc*lm/Hm;
C4 = -2*(Bfs-ufs*Sf*Hfs)/u0;

%% Ferro

Hf = (C1 + C2*lg/Sg)/(C3+C4*lg/Sg);
Bf = Bfs + ufs*(Hf-Hfs);

%%  Gap

theta = atand(dz./dx);

Bg = Bf*Sf/Sg;

Bgx = Bg*cosd(theta);
Bgz = Bg*sind(theta);

%% Força

Fx = (Bgx^2*Sg)/(u0);
Fz = (Bgz^2*Sg)/(u0);

end