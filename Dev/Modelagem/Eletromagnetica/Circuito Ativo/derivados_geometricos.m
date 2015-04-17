function [ m ] = derivados_geometricos( m, dx, dy )
%% Calcula constantes geometricas do mancal com base
% nos valores construtivos

%% Estator
m.rei = m.ree-m.wef;        % Raio interno ferro estator externo
m.pei = 2*pi*m.rei/m.NFRAC; % perímetro raio interno estator 
m.pee = 2*pi*m.ree/m.NFRAC; % perímetro raio externo estator 
m.Sm  = pi*(m.ree^2 - (m.ree-m.wm)^2)/m.NFRAC;   % Área da seccao ímã (validado)
m.Sef = 2*pi*(m.ree - m.wef/2)*m.hef/m.NFRAC;    % Área do ferro estator externo (42.58)

%% Gap
m.hge = m.hef;                     % Algura do ferro rotor = altura do gap
m.lg  = sqrt((m.wge+dx)^2 + dy^2); % Comprimento do gab em funcao do deslocamento em x e y 
m.Sge = m.AS*2*pi*(m.ree - m.lg/2)*(m.hge+dy)/m.NFRAC;% Area do gap

m.dx = dx;
m.dy = dy;

%% Rotor
m.rre = m.rei-m.wge; % Raio rotor externo ferro
m.rri = m.rre-m.wrf; % Raio rotor interno ferro
m.Srf = 2*pi*(m.rre - m.wrf/2)*m.hef/m.NFRAC;    % Area do ferro rotor           (41.74)
m.Srr = pi*((m.rri+m.wrr)^2-m.rri^2)/m.NFRAC;    % Area do retorno rotor         (validado)

%% Núcleo

% raios
                % Raio estator nucleo externo 
m.rene = m.rri-m.wgi;
                % Raio estator interno externo
m.reie = m.rene-m.wnb;
                % Raio estator interno interno
m.reii = m.reie-m.wei;

% perimetros
                % perimetro estator nucleo externo
m.pene  = 2*pi*m.rene;

% encontrando porcentangem referente ao nucleo
% Ref. C1
theta = tan(m.rnb/m.rene); 
parte = theta/(2*pi);

% Areas
                % Area nucleo da bobina externo (com ar)
m.Snbe   = 2*pi*m.rene*m.hnb*(2*parte);

 
%% Total

m.Vm = m.Sm*m.hm+2*m.Sef*m.wef+2*m.Srf*m.wrf+m.Srr*m.wrr; % Volume estimado Total



end

