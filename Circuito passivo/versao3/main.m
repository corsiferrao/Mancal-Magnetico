clear

% Inicialização
parametros;
load iron;

% entreferro
wge = wge - 0E-3;

% Valor inicial
Hef = 3E4;
Hrf = 3E4;
Hrr = 3E4;

% loop para convergencia
for i=1:50

    % Valores iniciais dos coeficiente
    uef = iron.MuH(Hef);
    urf = iron.MuH(Hrf);
    urr = iron.MuH(Hrr);

    % Relutancias
    Rm  = hm/(um*Sm);
    Ref = wef/(uef*Sef);
    Rge = wge/(u0*Sge);
    Rre = wrf/(urf*Srf);
    Rrr = hm/(urr*Srr);
    
    SumR = Rm+2*Ref+2*Rge+2*Rre+Rrr;
 
    
    Rml = (0.318*pee*log(1+2*(ree*0.050)/pee))/u0;
    Rms = 0.318*pee/u0;

    SumL = Rml+Rms;
    
    phym =     
    
    
    % Cálculo do fluxo magnético
    Fc   = (Hc*hm);
    phym = 0.8*Fc/SumR;

    % Calculo do vetor campo mag. nos componentes do sistem    
    Bm      = phym/Sm;
    Bef     = phym/Sef;
    Bge(i)  = phym/Sge;
    Brf     = phym/Srf;
    Brr     = phym/Srr;
       
    % Atualiza valor do campo magnético
    Hef = Bef/uef/2 + Hef/2;  % - H->B
    Hrf = Brf/urf/2 + Hrf/2;
    Hrr = Brr/urr/2 + Hrr/2;
end



Fx = 2*(Bge(i)^2*Sge)/(2*u0);

% campo magnetico ima
Hm = (Bm-Br)*Hc/Br;

%%
figure
    plot(Bge, 'o');
    title('Convergencia gap');

%%
figure
hold on
    plot(-Hc:0,Br+Br/Hc.*(-Hc:0));
    plot((Bm-Br)*Hc/Br,Bm, 'O', 'color', 'r');
    title('pnt de operação Ima');
hold off








