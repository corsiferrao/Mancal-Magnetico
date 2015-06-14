function [ m ] = derivados_geometricos( m, dx, dy )
%% Calcula constantes geometricas do mancal com base
% nos valores construtivos

%% Circuito passivo
% raios
m.rei  = m.ree-m.wef; % Raio interno ferro estator externo
m.rre  = m.rei-m.wge; % Raio rotor externo ferro
m.rri  = m.rre-m.wrf; % Raio rotor interno ferro

% Atualiza
m.hge  = m.hef;   % Algura do ferro rotor

% Comprimento do gab em funcao do deslocamento em x e y 
m.lg = sqrt((m.wge+dx)^2 + dy^2);

% perimetros
m.pei = 2*pi*m.rei/m.NFRAC; % perímetro raio interno estator 
m.pee = 2*pi*m.ree/m.NFRAC; % perímetro raio externo estator 

% áreas
m.Sm  = pi*(m.ree^2 - (m.ree-m.wm)^2)/m.NFRAC;   % Área da seccao ímã            (validado)
m.Sef = 2*pi*(m.ree - m.wef/2)*m.hef/m.NFRAC;    % Área do ferro estator externo (42.58)
m.Srf = 2*pi*(m.rre - m.wrf/2)*m.hef/m.NFRAC;    % Area do ferro rotor           (41.74)
m.Srr = pi*((m.rri+m.wrr)^2-m.rri^2)/m.NFRAC;    % Area do retorno rotor         (validado)
m.Sge = m.AS*2*pi*(m.ree - m.lg/2)*(m.hge+dy)/m.NFRAC;% Area do gap

% Volume estimado Total
m.Vm = m.Sm*m.hm+2*m.Sef*m.wef+2*m.Srf*m.wrf+m.Srr*m.wrr;

%% 

end

