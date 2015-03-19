% Rafael Corsi
% Mancal magnético - Dissertação de Mestrado
% 10.4.14
%
% Resumo :
%  Analise dos resultados

load Comsol;

for i=1:1:4
   [fx,fy] = f_ativo(i,0.6E-3,0.6E-3,0.6E-3);
   Analitico.I(i) = i;
   Analitico.Fx(i) = fx;
   Analitico.Fy(i) = fy;
end

figure
    title('Fx x I');
    hold on
        plot(Comsol.I(1:2)   , Comsol.Fx(1:2)   , 'b');
        plot(Analitico.I(1:2), Analitico.Fx(1:2), 'r');
    hold off
    legend('Comsol', 'Analitico');

%%
figure
   title('Fy x I');
    hold on
        plot(Comsol.I, Comsol.Fy(2:5), 'b');
        plot(Analitico.I, Analitico.Fy, 'r');
        legend('Comsol', 'Analitico');
    hold off
