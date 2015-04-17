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

% calcula gap com base no deslocamento x e y do rotor
l = lg(m);

% calcula relutancia gaps
RgA = R(la,m.Snbe,mag.u0);




