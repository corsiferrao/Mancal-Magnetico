%% Tratamento de dados do mancal otimziado
% rafael Corsi

% load otimziado dx
load ativo_otimizado_I_dx_03;

i = find(ativo_otimizado_I_dx_03.f <= 0);
plot(ativo_otimizado_I_dx_03.i(1:i), ativo_otimizado_I_dx_03.f(1:i),'Marker','+');
hold on
plot(ativo_otimizado_I_dx_03.i(i:end), ativo_otimizado_I_dx_03.f(i:end),'r','Marker','+');
hold off
ylabel('F [N]');
xlabel('I [A]');

belezura
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx03',1);


%% 
load ativo_otimizado_I_dx_00;

figure
plot(ativo_otimizado_I_dx_00.i, ativo_otimizado_I_dx_00.fx,'Marker','+');

ylabel('F [N]');
xlabel('I [A]');

belezura
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx00',1);

%%
fit(ativo_otimizado_I_dx_00.i, ativo_otimizado_I_dx_00.fx, 'poly2')
fit(ativo_otimizado_I_dx_00.i(1:3), ativo_otimizado_I_dx_00.fx(1:3), 'poly1')

%%
fit(ativo_otimizado_I_dx_03.i, ativo_otimizado_I_dx_03.f, 'poly2')
fit(ativo_otimizado_I_dx_03.i(1:3), ativo_otimizado_I_dx_03.f(1:3), 'poly1')