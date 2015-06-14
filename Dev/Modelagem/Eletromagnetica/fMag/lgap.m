function [l] = lgap(m)
%% comprimento do gap entre os nucleos
% Rafael Corsi
% 14/4/15
% Mancal Magnétic

%% Diretos : [A C E G]
la = m.wgi - m.dx;
lc = m.wgi + m.dy;
le = m.wgi + m.dx;
lg = m.wgi - m.dy;

%% Indiretos : [B D F H]
% via analise geométrica do descolamento
syms x;
syms y;

% [ B e F]
mo = -1;   % os nucleos estao defasados em 45 graus

[x0 y0] = solve((x-m.dx)^2+(y-m.dy)^2==m.rri^2, y==mo*x, x , y);

h  = double(sqrt(x0(1)^2+y0(1)^2));
lf = h-m.rene;

h  = double(sqrt(x0(1)^2+y0(2)^2));
lb = h-m.rene;

% [ D e H]
mo = 1;   

[x0 y0] = solve((x-m.dx)^2+(y-m.dy)^2==m.rri^2, y==mo*x, x , y);

h  = double(sqrt(x0(1)^2+y0(1)^2));
ld = h-m.rene;

h  = double(sqrt(x0(1)^2+y0(2)^2));
lh = h-m.rene;

l = [la lb lc ld le lf lg lh];

end

 