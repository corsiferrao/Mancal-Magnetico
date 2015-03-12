function [Fx, Fy, Bge, Bm, Bef ] = resolve(m, mag, dx, dy)
%%

load iron;

% Valores iniciais
Hef = 2E4;
Hrf = 2E4;
Hrr = 2E4;

% loop para convergencia
% método de Newton
for i=1:20

    % Valores iniciais das permeabilidades
    uef = iron.MuH(Hef);
    urf = iron.MuH(Hrf);
    urr = iron.MuH(Hrr);

    % Relutancias
    Rp  = m.hm/(mag.um*m.Sm);           % Ima
    Ref = m.wef/(uef*m.Sef);            % estator externo
    Rrf = m.wrf/(urf*m.Srf);            % rotor ferro
    Rrr = m.hm/(urr*m.Srr);             % rotor retorno
    Rge = m.lg/(mag.u0*m.Sge);          % gap

    % Permeace de leakage no gap de acordo com 
    % http://product.tdk.com/en/products/magnet/pdf/e371_circuit.pdf
    Pgl1 = 0.264*mag.u0*m.pei;
    Pgl2 = 0.64*mag.u0*m.pei/(m.lg/(m.wef*0.3)+1);
    Pgl3 = 0.077*mag.u0*m.lg;
    Pgl4 = mag.u0*m.wef*0.3/4;
    
    Pgl  = Pgl1+Pgl2+Pgl3+Pgl4;     % somatoria l gap
    Rgl  = inv(Pgl);
    SumRg = 1/(Pgl+inv(Rge));       % associacao //
            
    % Permeace de leakage no ima de acordo com 
    % http://product.tdk.com/en/products/magnet/pdf/e371_circuit.pdf    
    Pl2 = 0.64*mag.u0*m.ree/(m.hm/(m.hm+2*m.hef)+1); 
    Rl = 1/Pl2;                             
    
    % analise de circuito
    SumF = 2*Ref+2*SumRg+2*Rrf+Rrr;  % Associacao série circutio gap
    RLF  = SumF*Rl/(SumF+Rl);        % Associacao // entre SumL e Rl
    Fc   = mag.Hc*m.hm;              % Coercive magnetic force

    % fluxo magnético
    phym  = Fc/(RLF+Rp);             % ima
    phyf  = RLF*phym/SumF;           % circuito gap
    phyl  = RLF*phym/Rl;             % leakage
    phyg  = phyf*SumRg/Rge;          % gap

    phyg = phyf*Rgl/(Rge+Rgl);
       
    
    % Calculo do vetor campo mag. nos componentes do sistema    
    Bm(i)   = phym/m.Sm;
    Bef(i)  = phyf/m.Sef;
    Bge(i)  = phyg/m.Sge;
    Brf(i)  = phyf/m.Srf;
    Brr(i)  = phyf/m.Srr;
       
    % Atualiza valor do campo magnético
    % via método de newton
    Hef = Bef(i)/uef/2 + Hef/2;  % - H->B
    Hrf = Brf(i)/urf/2 + Hrf/2;
    Hrr = Brr(i)/urr/2 + Hrr/2;
end


%% Força de atração

theta = atand(dy./m.lg);

Bgex = Bge(i)*cosd(theta);
Bgey = Bge(i)*sind(theta);

Sgex = m.Sge;
Sgey = m.Sge;

% tentando novo modelo
%alfa  = dy/m.hef;
%Sgex  = (1-alfa)*m.Sge;
%Sgey  = alfa*m.Sge;
%Bgex = (1-alfa*30)*Bge(i)*cosd(theta);
%Bgey = (alfa*30)*Bge(i)*sind(theta);


Fx = 2*(Bgex^2*Sgex)/(2*mag.u0);
Fy = 2*(Bgey^2*Sgey)/(2*mag.u0);

%% Analise de Convergência 

%  Hm = (Bm-mag.Br)*mag.Hc/mag.Br;
%  
%  l = 1:i;
%  figure
%     hold on
%      plot(l, Bm, '.' , ...
%           l, Bef, '.',...
%           l, Bge, '.', ...
%           l, Brf, '.', ...
%           l, Brr, '.');
%      axis([0 i 0 2]);
%      xlabel('Interações'); 
%      ylabel('B(T)'); 
%      legend('Bm','Bef','Bge','Brf','Brr'); 
%      belezura
%      %title('Convergencia B no gap');

%% campo magnetico ima e pnt de operação
% figure
% hold on
%     plot(-mag.Hc:0,mag.Br+mag.Br/mag.Hc.*(-mag.Hc:0));
%     plot((Bm-mag.Br)*mag.Hc/mag.Br,Bm, 'O', 'color', 'r');
%     title('pnt de operação Ima');
% hold off


%%
%res.Fy = Fy; res.Bge = Bge;
end

