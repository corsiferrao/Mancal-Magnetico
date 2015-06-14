
% Inicialização
parametros;

load iron;

%%
% Valores iniciais

Hefn(1) = 1.4E4;
Hrfn(1) = 4.1E3;
Hrrn(1) = 2.0E3;

uefn(1) = iron.MuH(Hefn);
urfn(1) = iron.MuH(Hrfn);
urrn(1) = iron.MuH(Hrrn);

% Inicio da interacao
Hgen = Hge2(uefn, urfn, urrn)
B = u0*Hgen


%%

for i=1:100
    % Atualiza campos 
    Hefn(i+1) = Hef(Hgen(i), Hefn(i));
    Hrfn(i+1) = Hrf(Hgen(i), Hrfn(i));
    Hrrn(i+1) = Hrr(Hgen(i), Hrrn(i));
    
    uefa = iron.MuH(Hefn(i))/2 + iron.MuH(Hefn(i+1))/2;
    urfa = iron.MuH(Hrfn(i))/2 + iron.MuH(Hrfn(i+1))/2;
    urra = iron.MuH(Hrrn(i))/2 + iron.MuH(Hrrn(i+1))/2;

    % Inicio da interacao
    Hgen(i+1) = Hge(uefa, urfa, urra);
end
