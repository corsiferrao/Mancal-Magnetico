%% Tratamento de dados do mancal otimziado
% rafael Corsi

% load otimziado dx
load ativo_otimizado_I;

plot(ativo_otimizado_I.I, ativo_otimizado_I.Fx-140,'Marker','+');
xlabel('F [N]');
ylabel('I [A]')
belezura
export_pdf('Eletromagnetica/Resultados/ativo_otimizado_fem_I_dx03',1);
