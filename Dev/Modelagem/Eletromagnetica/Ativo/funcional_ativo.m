function F = funcional_ativo(po)
%% Funcional
% Toda interação devemos fazer 2 testes
%  1. Deslocamento em dy, dx= nominal
%  2. Deslocamento em dx, dy= nominal
%  3. Deslocamento nominal 

global Fx;
global Lmain;
global V;
global Gi;
global Im;
global in;

global version;

parametros_magneticos;
parametros_geometricos;
load resultados_otimizacao_passivo;

%% carrega valores da otimização do passivo
m.hef = hef;
m.wef = wef;
m.wm  = wm;
m.hm  = hm;
m.wge = wge;
m.wrf = wrf;
m.wrr = wrr;
m.ree = ree;

%% atualiza valores
m.wgi = po(1);
m.nnb = po(2);
m.hnb = po(3);
m.lnb = po(4);
m.wei = po(5);
m.rnb = po(6);

% % interação 1:
dx = -m.wgi;
dy = 0;

% calcula derivados geométricos
m = derivados_geometricos(m, dx, dy);

% resolve_passivo
I  = [Im -Im/2 0 0 0 0 0 -Im/2];
[r.Fx, r.Fy, r.Lmain] = resolve_ativo(dx, dy,I);

  
%% Calcula valor do Funcional

F = merito_ativo(r.Fx, r.Lmain, m.Vma, m.wgi, version );

%% global

Fx(in)      = r.Fx;
V(in)       = m.Vma;
Lmain(in)   = r.Lmain;
Gi(in) = m.wgi;

in = in+1;


