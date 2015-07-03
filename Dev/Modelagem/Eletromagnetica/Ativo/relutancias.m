%% Relutancias do circuito ativo
% Rafael Corsi
% 7/3/15
% Mancal Magnético


% Deslocamentos relativos
dx = 1E-4;
dy = 0;

% Parametros
parametros_geometricos;
parametros_magneticos;
m = derivados_geometricos(m,dx,dy);

% calcula gap com base no deslocamento x e y do rotor
[la,lb,lc,ld,le,lf,lg,lh]=lgap(m);

% Permeabilidade inicial do rotor
ufrAB = 2E4;
ufrBC = ufrAB; 
ufrCD = ufrAB; 
ufrDE = ufrAB; 
ufrEF = ufrAB; 
ufrFG = ufrAB; 
ufrGH = ufrAB; 
ufrHA = ufrAB; 

ufnA = 2E4;
ufnB = ufnA; 
ufnC = ufnA; 
ufnD = ufnA; 
ufnE = ufnA; 
ufnF = ufnA; 
ufnG = ufnA; 
ufnH = ufnA; 

%% inicio interação

% calcula relutancia gaps
RgA = R(la,m.Snbe,mag.u0);
RgB = R(la,m.Snbe,mag.u0);
RgC = R(la,m.Snbe,mag.u0);
RgD = R(la,m.Snbe,mag.u0);
RgE = R(la,m.Snbe,mag.u0);
RgF = R(la,m.Snbe,mag.u0);
RgG = R(la,m.Snbe,mag.u0);
RgH = R(la,m.Snbe,mag.u0);

% calcula relutancais rotor
lr = m.prr/8;
RrAB = R(lr, m.Srr, ufrAB);
RrBC = R(lr, m.Srr, ufrBC);
RrCD = R(lr, m.Srr, ufrCD);
RrDE = R(lr, m.Srr, ufrDE);
RrEF = R(lr, m.Srr, ufrEF);
RrFG = R(lr, m.Srr, ufrFG);
RrGH = R(lr, m.Srr, ufrGH);
RrHA = R(lr, m.Srr, ufrHA);

% calcula relutancais nucleo
ln = m.wnb;
RnA = R(ln, m.Snbe, ufnA);
RnB = R(ln, m.Snbe, ufnB);
RnC = R(ln, m.Snbe, ufnC);
RnD = R(ln, m.Snbe, ufnD);
RnE = R(ln, m.Snbe, ufnE);
RnF = R(ln, m.Snbe, ufnF);
RnG = R(ln, m.Snbe, ufnG);
RnH = R(ln, m.Snbe, ufnH);

% calcula retorno estator
lf = m.peie/8;
RfAB = R(lf, m.Sei, ufnA);
RfBC = R(lf, m.Sei, ufnB);
RfCD = R(lf, m.Sei, ufnC);
RfDE = R(lf, m.Sei, ufnD);
RfEF = R(lf, m.Sei, ufnE);
RfFG = R(lf, m.Sei, ufnF);
RfGH = R(lf, m.Sei, ufnG);
RfHA = R(lf, m.Sei, ufnH);

