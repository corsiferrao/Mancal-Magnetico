function F = funcional_ativo(po)
%% Funcional
% Toda interação devemos fazer 2 testes
%  1. Deslocamento em dy, dx= nominal
%  2. Deslocamento em dx, dy= nominal
%  3. Deslocamento nominal 

global Fx;
global Lmain;
global V;
global Im;
global in;

global version;

parametros_magneticos;
parametros_geometricos;

% atualiza valores
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

F = merito_ativo(r.Fx, r.Lmain, m, version );

%% global

Fx(in)      = r.Fx;
V(in)       = m.Vm;
Lmain(in)   = r.Lmain;

in = in+1;


