
% parametros modelo
Rr = 0.1116/2;          % raio externo do ferro central do rotor [m]
Rb = 0.1124/2;          % raio interno do batente [m]
m = 4.7e-5*7.86e3;      % massa do rotor [kg]

gb = 0.4e-3;            % gap para o batente [m]
gi = 0.6e-3;            % gap para o estator interno [m]

N = 300;                % numero de voltas por enrolamento
A = 236e-6;             % area do polo do estator interno [m2]
R = 4;                  % resistencia de cada enrolamento [ohms]
L = [-57.6135 0.0908];  % indutancia = L(1).gap + L(2)
Lm = L(1)*gi+L(2);      % indutancia media
%L = [0 L(1)*gi + L(2)];

Km = 60e3;              % rigidez radial passiva [N/m]
Ke = [3.8e-9 2.86e-3];  % constantes magneticas dos enrolamentos

Kb = 60e3;              % rigidez radial ativa [N/m]

E = 3e9;                % elastificade do nylon
Lb = 5.3e-3;            % profundidade (radial) do batente [m]
Hb = 8e-3;              % altura (axial) do batente [m]
dA = [1.435e2 3.335e-2];% A = dA(1)*dL^2 + dA(2)*dL (area de penetracao no batente) [m2]
Ab = dA * [1e-8 1e-4]'; % area de penetracao a meia excurcao [m2]
Kb = E*Hb*Ab/Lb;        % contante elastica a meia escursao [N/m]

% modelos
Gp = tf(1,[m 0 -Km]);   % planta
Ga = tf(Kb,[Lm R]);     % atuador
G = ss(Ga*Gp);

% parametros controlador
Vmax = 30;              % tensao maxima de excitacao das bobinas [V]
