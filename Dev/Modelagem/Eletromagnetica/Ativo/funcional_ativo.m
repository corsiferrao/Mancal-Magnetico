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
dx = m.wgi;
dy = 0;

    % calcula derivados geométricos
    m = derivados_geometricos(m, dx, dy);

    % resolve_passivo
    I  = [Im Im/2 0 0 0 0 0 Im/2];
    r1 = resolve_ativo(I, mag, dx, dy);

  
%% Calcula valor do Funcional

dbeftemp = abs(r1.Bef-r3.Bef); %diferencial
F = merito( r1.Fx, r2.Fy, m.Vm, dbeftemp, m, version );

%% global

Fx(in)      = r3.Fx;
Fy(in)      = r2.Fy*m.NFRAC;
V(in)       = m.Vm;
dBef(in)    = dbeftemp;

in = in+1;


