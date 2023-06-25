% Codigo que grafica las l�neas de muestreo del crucero BTS10.
% (Sampling lanes graphic from BTS10 cruise.)

clear
close all
load datosBTS10
load datosDQBTS10

for linea = 1:5

lance = ind(linea).ilance; latd = lat(lance); lond = lon(lance);
    
% Encuentra las distancias de separacion entre estaciones de muestreo.
% (Find the separation distances between sampling stations.)
[dist,angles] = sw_dist(latd,lond,'km'); dist = dist*1000;

% Encuentra distancias 'x' y 'y' de las coordenadas geograficas de los
% puntos de muestreo.
% (Find 'x,y' geographical coordinates distances of sampling points.)
alphas = angles.*pi/180;
y = dist.*sin(alphas); y_neg = find(y < 0);
if ~isempty(y_neg); y(y_neg) = y(y_neg)* - 1; else
end % ~isempty(y_neg)
x = sqrt(dist.^2 - y.^2); 
x = x'; 
x = [0 cumsum(x(end:-1:1))];
x = fliplr(x);
x = x/1000;  % y = [0;cumsum(y(end:-1:1))];  y = y/1000; y = fliplr(y);

isopics1 = [round(min(min(DP(:,lance)))):round(max(max(DP(:,lance))))];
if linea == 1; distancias = [0;1;2;3;4.5;5.5]; rang = [1:30]; end
if linea == 2; distancias = [0;1.3;2.5;4;5;6.5]; rang = [1:70]; end
if linea == 3; distancias = [0;1;2;3;4;5.5;6.5;7;7.5]; rang = [1:400]; end
if linea == 4; distancias = [0;1;1.8;2.5;3.5;4.5]; rang = [1:50]; end
if linea == 5; distancias = [0;.5;1;2;2.5]; rang = [1:250]; end

figure(linea); 

subplot(2,2,1); pcolor(x,P(rang),S(rang,lance)); shading interp; 
int = [round(min(S(:))):(round(max(S(:)))-round(min(S(:))))/10:round(max(S(:)))];
hcb = colorbarf(int);
% h = colorbar; 
% set(h,'YLim',[min(S(:)) max(S(:))]); caxis([min(S(:)) max(S(:))]);
% cX = caxis; 
hold on; [C,hcb] = contour(x,P,DP(:,lance),isopics1,'k','LineWidth',1,'LineStyle','--'); clabel(C,hcb,'FontSize',7);
% caxis(cX)
set(gca,'XDir','reverse','YDir','reverse');
set(gca,'XAxisLocation','top')
set(gca,'XTickMode','manual','XTick',fliplr(x),'TickDir','out','XGrid','on','GridLineStyle',':','Layer','top')
set(gca,'XTickLabel',fliplr(lance),'FontSize',7)
title('Salinidad (ups)'); ylabel('Presi�n (dbar)'); 
% text(-9,-150,['BTS10: L�nea exterior ',num2str(linea)],'FontSize',10,'FontWeight','bold');

subplot(2,2,4); pcolor(x,P(rang),O2(rang,lance)); shading interp; 
int = [round(min(O2(:))):(round(max(O2(:)))-round(min(O2(:))))/10:round(max(O2(:)))];
hcb = colorbarf(int); 
% set(h,'YLim',[min(O2(:)) max(O2(:))]); caxis([min(O2(:)) max(O2(:))]);
% cX = caxis; 
hold on; [C,hcb] = contour(x,P,DP(:,lance),isopics1,'k','LineWidth',1,'LineStyle','--'); clabel(C,hcb,'FontSize',7);
% caxis(cX)
set(gca,'XDir','reverse','YDir','reverse');
set(gca,'XTickMode','manual','XTick',fliplr(x),'TickDir','out','XGrid','on','GridLineStyle',':','Layer','top')
set(gca,'XtickLabel',{distancias},'FontSize',7)
title('Ox�geno disuelto (ml{\cdot}l^-^1)','FontSize',7); xlabel('Distancia (km)','FontSize',7); 

subplot(2,2,3); pcolor(x,P(rang),T(rang,lance)); shading interp; 
int = [round(min(T(:))):(round(max(T(:)))-round(min(T(:))))/10:round(max(T(:)))];
hcb = colorbarf(int);
% cX = caxis; 
hold on; [C,hcb] = contour(x,P,DP(:,lance),isopics1,'k','LineWidth',1,'LineStyle','--'); clabel(C,hcb,'FontSize',7);
% caxis(cX)
set(gca,'XDir','reverse','YDir','reverse');
set(gca,'XTickMode','manual','XTick',fliplr(x),'TickDir','out','XGrid','on','GridLineStyle',':','Layer','top')
set(gca,'XtickLabel',{distancias},'FontSize',7)
title('Temperatura (�C)'); ylabel('Presi�n (dbar)','FontSize',7); xlabel('Distancia (km)','FontSize',7); 

subplot(2,2,2); plot(S(:,lance),T(:,lance),'.b');
xlabel('Salinidad (ups)','FontSize',7); ylabel('Temperatura (�C)','FontSize',7);
set(gca,'FontSize',7)
axis square
hold on
isopics2 = [min(min(DP(:,lance))):(max(max(DP(:,lance)))-min(min(DP(:,lance))))/10:max(max(DP(:,lance)))];
gsw_SA_CT_plot4([min(SA(:)) max(SA(:))],[min(TC(:)) max(TC(:))],0,isopics2,'')

Smax_data = max(max(S(:,lance))); Smin_data = min(min(S(:,lance)));
Tmax_data = max(max(T(:,lance))); Tmin_data = min(min(T(:,lance)));
Smax = Smax_data + 0.1*(Smax_data - Smin_data);
Smin = Smin_data - 0.1*(Smax_data - Smin_data);
Tmax = Tmax_data + 0.1*(Tmax_data - Tmin_data);
Tmin = Tmin_data - 0.1*(Tmax_data - Tmin_data);

axis([Smin Smax Tmin Tmax]);


end
