function F = merito1(po)
%% Funcional
% Toda interação devemos fazer 2 testes
%  1. Deslocamento em dy, dx= nominal
%  2. Deslocamento em dx, dy= nominal
%  3. Deslocamento nominal 

global in;
global Fx;
global Fy;
global V;
global dBef;

parametros_magneticos;
parametros_geometricos;

% atualiza valores
m.hef = po(1);
m.wef = po(2);
m.wm  = po(3);
m.hm  = po(4);
m.wge = po(5);
m.wrf = po(6);
m.wrr = po(7);
m.ree = po(8);


% valores do deslocamento
dxx = m.wge; dyy = 0.2E-3;

% % interação 1:
dx = dxx/2; dy=0;

    % calcula derivados geométricos
    m = derivados_geometricos(m, dx, dy);

    % resolve
    r1 = resolve(m, mag, dx, dy);

% % interação 2:
 dx = 0; dy=dyy;
 
     % calcula derivados geométricos
     m = derivados_geometricos(m, dx, dy);
 
     % resolve
     r2 = resolve(m, mag, dx, dy);
    
% interação 3:
dx = 0; dy=0;

    % calcula derivados geométricos
    m = derivados_geometricos(m, dx, dy);

    % resolve
    r3 = resolve(m, mag, dx, dy);
  
%% Calcula valor do Funcional

P1 = r3.Fx/10;              % pondera Fx
P2 = 100/(r2.Fy*m.NFRAC);   % pondera Fy 
P3 = 10*abs(r1.Bef-r3.Bef); % pondera Delta Bef
P4 = m.Vm*1E6/10;           % pondera volume

F  = P1 + P2 + P3 + P4;     % calcula funcional

%% global
Fx(in)      = r3.Fx;
Fy(in)      = r2.Fy;
V(in)       = m.Vm;
dBef(in)    = abs(r1.Bef-r3.Bef);

in = in+1;


