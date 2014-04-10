%% Fev. 2014
% Rafael Corsi Ferrao
% Cálculo do campo B e Força x Distância 
% com campo no ferro saturado do circuito 
% magnético passivo


Hc = 1054E3;
Br = 1.29;

dz = 0.0E-3;
%dz = [0.0:0.1:1.2]*1E-3;

%dx = 1.2*ones(1,size(dz,2))*1E-3;
dx = [0.6:0.1:1.8]*1E-3;

lg = sqrt(dx.^2+dz.^2);

hfee = 4E-3;    % Altura ferro
wfee = 14E-3;   % Largura do ferro
reei = 61E-3;   % Raio interno ferro
re = 75E-3;     % Raio externo
wm = 8E-3;      % Largura imã
Hm = 10E-3;     % Altura do ima

%AS = 1.08; % Fator de espraiamento da área
AS = 1.08;

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
Sm = wm*2*pi*(reei+wfee-wm)/8;
Sf = hfee*2*pi*(reei)/8;
Sg = hfee*2*pi*(reei-lg./2)/8*AS;

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
ax = Bgx.^2;
az = Bgz.^2;

Fx = -ax.*f/1E3;
Fz = -az.*f/1E3 ;

%% Importa dado comsol

% Dx variável Dy cnt
[Comsol.Dx.dx ,Comsol.Dx.Fx] = importcsv_Comsol_Fx('Fx:dx=-0,6-1,2:dz=0.csv');

% Dy variável Dx cnt
%[Comsol.Dz.dz ,Comsol.Dz.Fz] = importcsv_Comsol('Fz:dx=1,2:dz=0-1,2.csv');

for i=1:13
    auxd(i) = 1.2-Comsol.Dx.dx(13+1-i);
    auxf(i) = Comsol.Dx.Fx(13+1-i);
end

   Comsol.Dx.dx = auxd;
   Comsol.Dx.Fx = auxf;  


%% Plot Calculado Fx


figure; hold on;
H1 = plot(dx*1E3,Fx,'MarkerFaceColor', 'b', ...
                   'MarkerEdgeColor', 'b',...
                   'Marker','o', ...
                   'DisplayName','Calculado');

H2 = plot(Comsol.Dx.dx, Comsol.Dx.Fx, ...
                   'MarkerFaceColor', 'r', ...
                   'MarkerEdgeColor', 'r',...
                   'Marker','o', ...
                   'Color','r', ...
                   'DisplayName','Comsol');

% Create legend
legend([H1,H2]);
title('Força X'); 
belezura
hold off

%% Plot Calculado Fz 

if dz ~= 0
    figure; hold on;

    H1 = plot(dz*1E3,Fz,'MarkerFaceColor', 'b', ...
                       'MarkerEdgeColor', 'b',...
                       'Marker','o', ...
                       'DisplayName','Calculado');

    H2 = plot(Comsol.Dz.dz,Comsol.Dz.Fz, ...
                       'MarkerFaceColor', 'r', ...
                       'MarkerEdgeColor', 'r',...
                       'Marker','o', ...
                       'Color','r', ...
                       'DisplayName','Comsol');
    % Create legend
    legend([H1,H2]);
    %title('Força Z');
end