% Codigo que grafica las lineas de muestreo del crucero BTS10.

clear
load datosBTS10

for linea = 1:6

for r = 1:2

if r == 1 && linea <= 5; lance = ind(linea).ilance; lat = lat(lance); lon = lon(lance);
elseif r == 2 ; lance = ind(linea).elance; lat = lat(lance); lon = lon(lance);
end

if r == 1 && linea == 6; break; end
    
% Encuentra las distancias de separacion entre estaciones de muestreo
[dist,angles] = sw_dist(lat,lon,'km'); dist = dist*1000;

% Encuentra distancias 'x' y 'y' de las coordenadas geograficas de los
% puntos de muestreo
alphas = angles.*pi/180;
y = dist.*sin(alphas); y_neg = find(y < 0);
if ~isempty(y_neg); y(y_neg) = y(y_neg)* - 1; else
end % ~isempty(y_neg)
x = sqrt(dist.^2 - y.^2);
x = [0 cumsum(x(end:-1:1))]; x = x/1000; x = fliplr(x); % y = [0;cumsum(y(end:-1:1))];  y = y/1000; y = fliplr(y);

figure(linea); subplot(2,2,1); pcolor(x,P,S(lance)); shading interp; 
h = colorbar; set(h,'YLim',[min(S) max(S)]); caxis([min(S) max(S)]);
set(gca,'XDir','reverse','YDir','reverse');
cX = caxis; hold on
[C,h] = contour(x,P,D,'k','LineWidth',1); clabel(C,h);
caxis(cX)

title('Salinidad (ups)'); ylabel('Presión (dbar)'); text(-9,-150,['Crucero BTS',num2str(k),'; L?nea ',num2str(linea)],'FontSize',12,'FontWeight','bold');
title('Oxígeno Disuelto (ml{\cdot}L^-^1)'); 
title('Temperatura (ºC)'); ylabel('Presión (dbar)'); xlabel('Distancia (km)'); 


end

end