function [ Fx, Fy ] = resolve_ativo(dx,dy,I)

%% Parametros

load iron;

parametros_geometricos;
parametros_magneticos;

%% inicializacao

% derivados
m = derivados_geometricos(m,dx,dy);

% Forcas eletromotriz
FM = I*m.nnb;

% Permeabilidade inicial do rotor
ufr0 = 4E4;
ufn0 = 4E4;
uff0 = 4E4;

%      AB    BC   CD   DE   EF   FG   GH   HA
ufr = [ufr0 ufr0 ufr0 ufr0 ufr0 ufr0 ufr0 ufr0]';
ufn = [ufn0 ufn0 ufn0 ufn0 ufn0 ufn0 ufn0 ufn0]';
uff = [uff0 uff0 uff0 uff0 uff0 uff0 uff0 uff0]';
% Relutancais

% calcula gap com base no deslocamento x e y do rotor
lg = lgap(m);
lr = m.prr/8;
lf = m.peie/8;
ln = m.wnb;

% calcula relutancia gaps
Rg = Rmm(lg,m.Snbe,mag.u0);

%% inicio interação
ufn0 = ufn;
ufr0 = ufr;
uff0 = uff;

% loop para convergencia
% método de Newton
for i=1:20
    
    if(i>1)
        Hn0 = Hn;
        Hr0 = Hr;
        Hf0 = Hf;
    end;
    
    % calcula relutancais rotor
    Rr = Rmm(lr,m.Srr, ufr);
    
    % calcula relutancais nucleo
    Rn = Rmm(ln, m.Snbe, ufn);
    
    % calcula retorno estator
    Rf = Rmm(lf, m.Sei, uff);
    
    % resolve malhas
    [phi I] = malhas_ativo(FM, Rg, Rn, Rf, Rr);
    
    % Vetor campo mag. calcula campos nos componentes
    Bg = abs(phi/m.Sgi);
    Bn = abs(phi/m.Snbe);
    Br = abs(I/m.Srrr);
    Bf = abs(I/m.Sei);
    
    Hg = Bg/mag.u0;
    Hn = Bn'/diag(ufn);
    Hr = Br'/diag(ufr);
    Hf = Bf'/diag(uff);
    
    % Atualiza permeabilidades
    % via método de newton-rapson
%     if i==1
%         ufn = iron.MuH(Hn)/2 + ufn/2;
%         ufr = iron.MuH(Hr)/2 + ufr/2;
%         uff = iron.MuH(Hf)/2 + uff/2;
%     else
%         ufn = ufn + (Hn-Hn0)'./(ufn-ufn0);
%         ufr = ufr + (Hr-Hr0)'./(ufr-ufr0);
%         uff = uff + (Hf-Hf0)'./(uff-uff0);
%     end;
    
    Hn = Bn./ufn/2 + Hn'/2;  % - H->B
    Hf = Bf./uff/2 + Hf'/2;
    Hr = Br./ufr/2 + Hr'/2;
    
    ufn = iron.MuH(Hn);
    ufr = iron.MuH(Hr);
    uff = iron.MuH(Hf);  
    
    auxBn(i) = Bn(2); 
    
    auxHr{i} = Hr;
    auxHn{i} = Hn;
    auxHf{i} = Hf;
    
end;

%% Força

projecao = diag([1 0.7071 1 0.7071 1 0.7071 1 0.7071]);

Fmag = ((Bg.^2*m.Sgi)/(2*mag.u0))'*projecao;

Fx = Fmag(1) + Fmag(2) - Fmag(4) - Fmag(5) -Fmag(6) + Fmag(8);

Fy = -Fmag(2)-Fmag(3)-Fmag(4)+Fmag(6)+Fmag(7)+Fmag(8);


% figure;
% plot(cellfun(@(x) x(1), auxHr), '.')
% figure
% plot(cellfun(@(x) x(1), auxHn), '.')
% figure
% plot(cellfun(@(x) x(1), auxHf), '.')


end

