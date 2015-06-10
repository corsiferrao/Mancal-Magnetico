%% Circuito Ativo, modelagem nao linear
% Rafael Corsi
% 4/15
% Mancal Magnético
clc
clear all


%% inicializacao
% Deslocamentos relativos
dy = 0;
x=1;
for Im=0:0.5:4
    for dx=-0.3:0.1:0.3
        I  = [Im Im/2 0 0 0 0 0 0 0 Im/2];
        [Fx(x) Fy(x)] = resolve_ativo(dx,dy,I);
        x = x+1;
    end
end

%%
dx=0;
Im = 2;
I  = [Im Im/2 0 0 0 0 0 0 0 Im/2];
resolve_ativo(dx,dy,I);

%%
load Comsol
figure
plot(Comsol(:,3), 'x');
hold
plot(Fx, 'o');