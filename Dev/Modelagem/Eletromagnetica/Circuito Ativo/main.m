%% Circuito Ativo, modelagem nao linear
% Rafael Corsi
% 4/15
% Mancal Magnético
clc
clear all

%% Parametros

load iron;

parametros_geometricos;
parametros_magneticos;

%% inicializacao
% Deslocamentos relativos
dx = 0E-4;
dy = 0;
I  = 10;

% Forcas eletromotriz

FA = m.nnb*I;
FB = 0;%m.nnb*I/2;
FC = 0;
FD = 0;
FE = 0;
FF = 0;
FG = 0;
FH = 0;m.nnb*I/2;

% derivados
m = derivados_geometricos(m,dx,dy);

% Permeabilidade inicial do rotor
ufr0 = 2E4;
ufn0 = 2E4;
uff0 = 2E4;

%      AB    BC   CD   DE   EF   FG   GH   HA
ufr = [ufr0 ufr0 ufr0 ufr0 ufr0 ufr0 ufr0 ufr0]'; 
ufn = [ufn0 ufn0 ufn0 ufn0 ufn0 ufn0 ufn0 ufn0]';
uff = [uff0 uff0 uff0 uff0 uff0 uff0 uff0 uff0]';
% Relutancais

% calcula gap com base no deslocamento x e y do rotor
lg =lgap(m);

% calcula relutancia gaps
Rg = R(lg,m.Snbe,mag.u0);


%% inicio interação

% loop para convergencia
% método de Newton
for i=1:150
            
    % calcula relutancais rotor
    lr = m.prr/8;
    Rr = R(lr,m.Srr, ufr);
    
    % calcula relutancais nucleo
    ln = m.wnb;
    Rn = R(ln, m.Snbe, ufn);
    
    % calcula retorno estator
    lf = m.peie/8;
    Rf = R(lf, m.Sei, uff);
     
    % resolve malhas
    malhas
    
    % calcula campos nos componentes
    Bg = abs(phi/m.Sgi/1.1);
    Bn = abs(phi/m.Snbe);
    Br = abs(phi/m.Srrr);
    Bf = abs(phi/m.Sei);
    
    Hg = Bg/mag.u0;
    Hn = Bn'/diag(ufn);
    Hr = Br'/diag(ufr);
    Hf = Bf'/diag(uff);
    
    % Atualiza permeabilidades
    % via método de newton
    ufn = iron.MuH(Hn)/2 + ufn/2;
    ufr = iron.MuH(Hr)/2 + ufr/2;
    uff = iron.MuH(Hf)/2 + uff/2;
       
    auxBg(i) = Bg(1);
    auxHn(i) = Hn(1);
    
end;
