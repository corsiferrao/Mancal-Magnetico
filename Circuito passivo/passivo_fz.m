%% Fev. 2014
% Z
% Rafael Corsi Ferrao
% Cálculo do campo B e Força x Distância 
% com campo no ferro saturado do circuito 
% magnético passivo



Hc = 1054E3;
Br = 1.29;

dz = [0.0:0.1:1.2]*1E-3;

dx = 1.2*ones(1,size(dz,2))*1E-3;

lg = sqrt(dx.^2+dz.^2);

hfee = 4E-3;    % Altura ferro
wfee = 14E-3;   % Largura do ferro
reei = 61E-3;   % Raio interno ferro
re = 75E-3;     % Raio externo
wm = 8E-3;      % Largura imã
Hm = 10E-3;     % Altura do ima

AS = 1.08; % Fator de espraiamento da área

Bfs = 1.6;
Hfs = 2E4;

B2 = 1.8;
H2 = 6E4;

ufs = (B2-Bfs)/(H2-Hfs);

u0 = 4*pi*1E-7;

%% correcao de nomenclatura
lm = Hm;
lf = wfee;      % linha de campo imã

%% Parametros de área 
Sm = wm*2*pi*(reei+wfee-wm);
Sf = hfee*2*pi*(reei);
Sg = hfee*2*pi*(reei-lg./2)*AS;

%% Calculo constantes

C1 = ((Bfs-ufs*Hfs)/(Sm*Br)+1)*Hc*lm;
C2 = 2*(Bfs-ufs*Sf*Hfs)/u0;
C3 = (ufs*Hc*lm)/(Sm*Br)+2*lf;
C4 = 2*(ufs*Sf)/(u0);

%% Ferro

Hf = (C1 - C2*lg./Sg)./(C2+C3*lg./Sg);
Bf = Bfs + ufs*(Hf-Hfs);

%%  Gap

theta =  atand(dz./dx);

Bg = Bf.*Sf/Sm;
Bgx = Bg.*cosd(theta);
Bgz = Bg.*sind(theta);
%% Força

%F= Bg.^2*2*Sg./(u0*lg.)

f = 2*Sg./(u0*lg);
az = Bgz.^2;

Fz = -az.*f/1E3 ;

%% Importa dado comsol


importcsv_Comsol_Fz
n = size(Comsol.Dz,1);

% for i=1:13
%     auxd(i) = Comsol.Dz(n+1-i);
%     auxf(i) = Comsol.Fz(n+1-i);
% end
% 
% Comsol.Dz = auxd;
% Comsol.Fz = auxf;

%% Plot Calculado Fz 

%Docking Figures Automatically
set(0,'DefaultFigureWindowStyle','docked') ;

    figure; hold on;

    H1 = plot(dz(1:4)*1E3,Fz(1:4),'MarkerFaceColor', 'b', ...
                       'MarkerEdgeColor', 'b',...
                       'Marker','o', ...
                       'DisplayName','Calculado');

    H2 = plot(Comsol.Dz(1:4),Comsol.Fz(1:4), ...
                       'MarkerFaceColor', 'r', ...
                       'MarkerEdgeColor', 'r',...
                       'Marker','o', ...
                       'Color','r', ...
                       'DisplayName','Comsol');
    % Create legend
    legend([H1,H2]);
    %title('Força Z');
