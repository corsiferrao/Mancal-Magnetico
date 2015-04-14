%% Relutancias do circuito ativo
% Rafael Corsi
% 7/3/15
% Mancal Magnético

% Deslocamentos relativos
dx = 1E-4;
dy = 0;

parametros_geometricos;
parametros_magneticos;
m = derivados_geometricos(m,dx,dy);

clear la lb lc ld le lf lg lh
[la, lb, lc, ld, le, lf, lg, lh ] = lg(m)




