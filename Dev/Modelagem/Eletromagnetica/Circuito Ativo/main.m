%% Circuito Ativo, modelagem nao linear
% Rafael Corsi
% 4/15
% Mancal Magnético
clc
clear all

%% load comsol 
load Comsol;

%%
parametros_geometricos;
parametros_magneticos;

%% inicializacao
% Deslocamentos relativos
dy = 0;
x=1;
for Im=0:0.5:4
    I  = [Im Im/2 0 0 0 0 0 0 0 Im/2];
    for dx=-0.3E-3:0.1E-3:0.3E-3
        [Fx(x) Fy(x)] = resolve_ativo(dx,dy,I);
        x = x+1;
    end;
end;

%%
c = 1;
xx =1;
yy =1;

for y=0:0.5:4
    for x=-0.3:0.1:0.3
        if y == 0 
            Comsolf(xx,yy) = 0;
        else
            Comsolf(xx,yy) = Comsol(c,3);
            c = c+1;
        end
        xx = xx +1;
    end
    yy = yy + 1;
    xx = 1;
end

%%
c = 1;
xx =1;
yy =1;

for y=0:0.5:4
    for x=-0.3:0.1:0.3
        if y == 0 
            Corsif(xx,yy) = 0;
        else
            Corsif(xx,yy) = Fx(c);
            c = c+1;
        end
        xx = xx +1;
    end
    yy = yy + 1;
    xx = 1;
end

%%

[X Y] = meshgrid(0:0.5:4,-0.3:0.1:0.3);
subplot(1,2,1)
surf(X,Y,Corsif*1.1);
subplot(1,2,2)
surf(X,Y,Comsolf);
colormap(jet)    % change color map
ylabel('dx [mm]');
xlabel('I [A]');
zlabel('F [N]');
title('Force (N) x current (A) x displacment (mm)')

%%

figure
plot(Comsol(:,3), 'x');
hold
plot(Fx(7:end)*1.2, 'o');