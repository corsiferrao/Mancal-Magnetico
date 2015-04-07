%% exporta os dados ?
global exportar;
exportar = 0;

%%
gb = 0.4e-3;            % gap para o batente [m]
gi = 0.6e-3;            % gap para o estator interno [m]
m = 4.7e-5*7.86e3;      % massa do rotor [kg]
N = 300;                % numero de voltas por enrolamento
R = 4;                  % resistencia de cada enrolamento [ohms]
L = [-57.6135 0.0908];  % indutancia = L(1).gap + L(2) <= Comsol
Lm = L(1)*gi+L(2);      % indutancia media 
Kb = 46.53E3;             % Força bobinas em [N/m]
Kp = 547.8E3;             % rigidez passivo [N/m]

% Funcao de transf em torno do ponto de operacao
Ga = tf(Kb,[Lm R]);      % Atuador
Gp = tf(1,[m 0 -Kp]);    % planta
G = ss(Ga*Gp);           % Sistema

%% Analise
pole(G)

%% Bode
% analise frequencia
figure
subplot(1,2,1)
rlocus(G)
subplot(1,2,2)
bode(G)
export_pdf('bode:rlocus:pnt:operacao');

%% simulaçao impacto
load('simualcao:saturacao:mancal.mat')
plot(scope_d.time(1:80), scope_d.signals.values(1:80,:));
xlabel('Tempo (s)');
ylabel('Posicao (m)');
belezura
export_pdf('dinamica:choque:rotor');

%% simulacao com corrente
load('simualcao:corrente:mancal.mat');
t = find(scope_fb.time >= 0.98, 1);

subplot1 = subplot(3,1,1);
plot(scope_vb.time(t:t+1500), scope_vb.signals.values(t:t+1500,:));
title('Tensao aplicada nas bobinas');
xlabel('t (s)')
ylabel('E (V)')
belezura

subplot(3,1,2)
plot(scope_ib.time(t:t+1500), scope_ib.signals.values(t:t+1500,:));
title('Corrente nas bobinas');
xlabel('t (s)')
ylabel('i (A)')
belezura

subplot(3,1,3)
plot(scope_pr.time(t:t+1500), scope_pr.signals.values(t:t+1500,:));
title('Deslocamento do rotor');
xlabel('t (s)')
ylabel('\Delta (m)')
belezura
export_pdf('dinamica:corrente:rotor');
