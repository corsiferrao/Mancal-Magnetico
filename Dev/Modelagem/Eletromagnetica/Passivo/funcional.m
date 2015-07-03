function F = funcional(po)
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

global version;


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

    % resolve_passivo
    r1 = resolve_passivo(m, mag, dx, dy);

% % interação 2:
 dx = 0; dy=dyy;
 
     % calcula derivados geométricos
     m = derivados_geometricos(m, dx, dy);
 
     % resolve_passivo
     r2 = resolve_passivo(m, mag, dx, dy);
    
% interação 3:
dx = 0; dy=0;

    % calcula derivados geométricos
    m = derivados_geometricos(m, dx, dy);

    % resolve_passivo
    r3 = resolve_passivo(m, mag, dx, dy);
  
%% Calcula valor do Funcional

dbeftemp = abs(r1.Bef-r3.Bef); %diferencial
F = merito( r1.Fx, r2.Fy, m.Vm, dbeftemp, m, version );

%% global

Fx(in)      = r3.Fx;
Fy(in)      = r2.Fy*m.NFRAC;
V(in)       = m.Vm;
dBef(in)    = dbeftemp;

in = in+1;


