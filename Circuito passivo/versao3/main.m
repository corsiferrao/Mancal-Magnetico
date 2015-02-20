%limpa variaveis
clear;
close all;

% Inicialização
parametros;
load iron;

% Valor inicial
Hef = 3E4;
Hrf = 3E4;
Hrr = 3E4;

% loop para convergencia
% método de Newton
for i=1:40

    % Valores iniciais das permeabilidades
    uef = iron.MuH(Hef);
    urf = iron.MuH(Hrf);
    urr = iron.MuH(Hrr);

    % Relutancias
    Rp  = hm/(um*Sm);               % Ima
    Ref = wef/(uef*Sef);            % estator externo
    Rrf = wrf/(urf*Srf);            % rotor ferro
    Rrr = hm/(urr*Srr);             % rotor retorno
    Rge = wge/(u0*Sge);             % gap

    % Permeace de leakage no gap de acordo com 
    % http://product.tdk.com/en/products/magnet/pdf/e371_circuit.pdf

    Pgl1 = 0.264*u0*pei;
    Pgl2 = 0.64*u0*pei/(wge/(wef*0.3)+1);
    Pgl3 = 0.077*u0*wge;
    Pgl4 = u0*wef*0.3/4;
    
    SumRg = 1/(Pgl1+Pgl2+Pgl3+Pgl4+inv(Rge)); % associacao //
            
    % Permeace de leakage no ima de acordo com 
    % http://product.tdk.com/en/products/magnet/pdf/e371_circuit.pdf    
    Pl2 = 0.64*u0*ree/(hm/(hm+2*hef)+1); 
    Rl = 1/Pl2;                             
    
    % analise de circuito
    SumF = 2*Ref+2*SumRg+2*Rrf+Rrr; % Associacao série circutio gap
    RLF  = SumF*Rl/(SumF+Rl);       % Associacao // entre SumL e Rl
    Fc   = Hc*hm;                   % Coercive magnetic force

    % fluxo magnético
    phym = Fc/(RLF+Rp);             % ima
    phyf = RLF*phym/SumF;            % circuito gap
    phyl = RLF*phym/Rl;              % leakage
    phyg = phyf*SumRg/Rge;          % gap


    % Calculo do vetor campo mag. nos componentes do sistem    
    Bm      = phym/Sm;
    Bef     = phyf/Sef;
    Bge(i)  = phyg/Sge;
    Brf     = phyf/Srf;
    Brr     = phyf/Srr;
       
    % Atualiza valor do campo magnético
    % via método de newton
    Hef = Bef/uef/2 + Hef/2;  % - H->B
    Hrf = Brf/urf/2 + Hrf/2;
    Hrr = Brr/urr/2 + Hrr/2;
end


%% Força de atração

Fx = 2*(Bge(i)^2*Sge)/(2*u0)

%% campo magnetico ima e pnt de operação

Hm = (Bm-Br)*Hc/Br;
figure
    plot(Bge, 'o');
    axis([0 i 0 2]);
    title('Convergencia B no gap');

%% Convergência 
figure
hold on
    plot(-Hc:0,Br+Br/Hc.*(-Hc:0));
    plot((Bm-Br)*Hc/Br,Bm, 'O', 'color', 'r');
    title('pnt de operação Ima');
hold off








