function F = funcional_passivo(po)
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
global Raio;
global Gap;
global Brr;

global version;


parametros_magneticos;
parametros_geometricos;

% atualiza valores
m.hef       = po(1);
wef_delta   = po(2);
m.wm        = po(3);
m.hm        = po(4);
m.wge       = po(5);
wrf_delta   = po(6);
m.wrr       = po(7);
m.ree       = po(8);

m.wef  = m.hm +wef_delta;
m.wrf  = m.wrr+wrf_delta;

% valores do deslocamento
dxx = 0.3E-3; 
dyy = 0.2E-3;

% % interação 1:
dx = dxx; dy=0;

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
F = merito_passivo( r1.Fx, r2.Fy*m.NFRAC, m.Vm, dbeftemp, r3.Brr, m.wge, m.ree, version );

%% global

Fx(in)      = r3.Fx;
Fy(in)      = r2.Fy*m.NFRAC;
V(in)       = m.Vm;
dBef(in)    = dbeftemp;
Gap(in)     = m.wge;
Raio(in)    = m.ree;
Brr(in)     = r3.Brr;
in = in+1;


