function F = merito1(po)
%% Funcional
% Toda interação devemos fazer 2 testes
%  1. Deslocamento em dy, dx= nominal
%  2. Deslocamento em dx, dy= nominal
%  3. Deslocamento nominal 

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
dxx = 100E-3; dyy = 0.2E-3;

% interação 1:
dx = dxx; dy=0;

    % calcula derivados geométricos
    m = derivados_geometricos(m, dx, dy);

    % resolve
    r1 = resolve(m, mag, dx, dy);

% % interação 2:
 dx = 0; dy=dyy;
 
     % calcula derivados geométricos
     derivados_geometricos(m, dx, dy);
 
     % resolve
     r2 = resolve(m, mag, dx, dy);
    
% interação 3:
dx = 0; dy=0;

    % calcula derivados geométricos
    derivados_geometricos(m, dx, dy);

    % resolve
    r3 = resolve(m, mag, dx, dy);
  
% Calcula valor do Funcional
%1/abs(r1.Bef-r3.Bef)

F = 2*abs(r1.Fx) + 1/abs(r2.Fy) + m.Vm*1E6;
