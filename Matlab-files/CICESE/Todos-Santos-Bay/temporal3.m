%% Ciclo para incrementar la posicion dentro de las variables estacionales
load bts_ext
inv = 1; prim = inv; ver = inv; oto = inv;

for cruc = 1:7
    for linea = 1:5
        display(['linea ',num2str(linea)])
        fecha(:,:,cruc,linea) = bts_ext(cruc,linea).datei;
        [YY,MM,DD,HH,MN,SS] = datevec(fecha(:,:,cruc,linea)); mes = nanmean(MM);
        if mes == 12 || mes <= 2
            if linea <= 5; inv = inv; end
            if linea == 5; inv = inv + 1; end
        elseif mes >= 3 && mes <= 5
            if linea <= 5; prim = prim; end
            if linea == 5; prim = prim + 1; end
        elseif mes >= 6 && mes <= 8
            if linea <= 5; ver = ver; end
            if linea == 5; ver = ver + 1; end
        elseif mes >= 9 && mes <= 11
            if linea <= 5; oto = oto; end
            if linea == 5; oto = oto + 1; end
        end
    end
    display(['cruc ',num2str(cruc)])
end

%% Para detectar errores en las matrices de datos observadas
load lineasBTS8nuevas; cruc = 8;
for linea = 1:5
    lance=E(linea).lance;S=E(linea).S;T=E(linea).T;O2=E(linea).O2;D=E(linea).D;
    linea
    lance
    for vars= 1:4
        switch vars
            case 1; var = S; var1 = ('Salinidad');
            case 2; var = T; var1 = ('Temperatura');
            case 3; var = O2; var1 = ('Oxigeno');
            case 4; var = D; var1 = ('Densidad');
        end
       figure; plot(var);
       ylabel([var1]); xlabel('No. de observaciones en la columna');
       title(['BTS',num2str(cruc),' linea ',num2str(linea)]);
    end
end
