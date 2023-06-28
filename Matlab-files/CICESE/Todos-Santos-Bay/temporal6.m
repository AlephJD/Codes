% Codigo para reacomodar datos de archivo de mareas para anclaje de HOBO's
% en Rincon de Ballenas.
% 16 de Abril de 2012

dat = load('ens_marea_2012-13(2).prd');

anio = [];mes = [];dia = [];hora = []; 
datos = [];
for i = 1:2:length(dat)
    dat2 = dat(i:i+1,4:end);
    datos = [datos;dat2(1,:)';dat2(2,:)'];
    anio = [anio;dat(i,3)*ones(length(dat2(1,:))*2,1)];
    mes = [mes;dat(i,2)*ones(length(dat2(1,:))*2,1)];
    dia = [dia;dat(i,1)*ones(length(dat2(1,:))*2,1)];
    for k = 1:24
        if k <= 12
            hh = k-1; hora = [hora;hh];
        end
        if k > 12 & k <= 24
            hh = k-1; hora = [hora;hh];
        end
    end
end

dat=[anio mes dia hora zeros(size(hora)) datos];