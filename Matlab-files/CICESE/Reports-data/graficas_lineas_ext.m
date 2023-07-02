% Codigo que grafica las líneas de muestreo del crucero BTS*. 
% (Graphics of sampling lanes and hydrographic variables from BTS* cruise.)

% Realizado por: Aleph Jimenez
% Para: CICESE

clear
load datosBTS10
load datosDQBTS10

for linea = 1:6

lance = ind(linea).elance; latd = lat(lance); lond = lon(lance);
    
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
if linea == 1; distancias = [0;2;5.5;8.5;15.5;22]; end
if linea == 2; distancias = [0;2;3.8;5.5;7.5;10.5;13.5;16;22;28]; end
if linea == 3; distancias = [0;1.5;3;6;9;12.5;19;25;31.5]; end
if linea == 4; distancias = [0;3;6;9;11.8;15;21;27;33;39]; end
if linea == 5; distancias = [0;3;6;9;11.9]; end
if linea == 6; distancias = [0;2.5;5;8;10.5;16;21.5;27;32]; end

figure(linea); 

subplot(2,2,1); pcolor(x,P,S(:,lance)); shading interp; 
int = [round(min(S(:))):(round(max(S(:)))-round(min(S(:))))/10:round(max(S(:)))];
hcb = colorbarf(int);
% h = colorbar;
% set(hcb,'YLim',[min(S(:)) max(S(:))]); caxis([min(S(:)) max(S(:))]);
hold on; [C,hcb] = contour(x,P,DP(:,lance),isopics1,'k','LineWidth',1,'LineStyle','--'); clabel(C,hcb,'FontSize',7);
% cX = caxis; caxis(cX)
set(gca,'XDir','reverse','YDir','reverse');
set(gca,'XAxisLocation','top')
set(gca,'XTickMode','manual','XTick',fliplr(x),'TickDir','out','XGrid','on','GridLineStyle',':','Layer','top')
set(gca,'XTickLabel',fliplr(lance),'FontSize',7)
title('Salinidad (ups)'); ylabel('Presión (dbar)'); 
% text(-9,-150,['BTS10: Línea exterior ',num2str(linea)],'FontSize',10,'FontWeight','bold');
% orient(fig_handle,orientation) 
% h = colorbarf(int,int,'Salinidad',[2.5 2.5],2,0.5,'ups'); 

subplot(2,2,4); pcolor(x,P,O2(:,lance)); shading interp; 
int = [round(min(O2(:))):(round(max(O2(:)))-round(min(O2(:))))/10:round(max(O2(:)))];
hcb = colorbarf(int); 
% h = colorbar;
% set(h,'YLim',[min(O2(:)) max(O2(:))]); caxis([min(O2(:)) max(O2(:))]);
hold on; [C,hcb] = contour(x,P,DP(:,lance),isopics1,'k','LineWidth',1,'LineStyle','--'); clabel(C,hcb,'FontSize',7);
% cX = caxis; caxis(cX)
set(gca,'XDir','reverse','YDir','reverse');
set(gca,'XTickMode','manual','XTick',fliplr(x),'TickDir','out','XGrid','on','GridLineStyle',':','Layer','top')
set(gca,'XtickLabel',{distancias},'FontSize',7)
title('Oxígeno disuelto (ml{\cdot}l^-^1)','FontSize',7); xlabel('Distancia (km)','FontSize',7); 

subplot(2,2,3); pcolor(x,P,T(:,lance)); shading interp; 
int = [round(min(T(:))):(round(max(T(:)))-round(min(T(:))))/10:round(max(T(:)))];
hcb = colorbarf(int); 
hold on; [C,hcb] = contour(x,P,DP(:,lance),isopics1,'k','LineWidth',1,'LineStyle','--'); clabel(C,hcb,'FontSize',7);
% cX = caxis;  caxis(cX)
set(gca,'XDir','reverse','YDir','reverse');
set(gca,'XTickMode','manual','XTick',fliplr(x),'TickDir','out','XGrid','on','GridLineStyle',':','Layer','top')
set(gca,'XtickLabel',{distancias},'FontSize',7)
title('Temperatura (ºC)'); ylabel('Presión (dbar)','FontSize',7); xlabel('Distancia (km)','FontSize',7); 

subplot(2,2,2); plot(S(:,lance),T(:,lance),'.b');
xlabel('Salinidad (ups)','FontSize',7); ylabel('Temperatura (ºC)','FontSize',7);
set(gca,'FontSize',7)
axis square
hold on
isopics2 = [22.5:.5:27.5];
gsw_SA_CT_plot4(SA(:,lance),TC(:,lance),0,isopics2,'')

Smax_data = max(max(S(:))); Smin_data = min(min(S(:)));
Tmax_data = max(max(T(:))); Tmin_data = min(min(T(:)));
Smax = Smax_data + 0.1*(Smax_data - Smin_data);
Smin = Smin_data - 0.1*(Smax_data - Smin_data);
Tmax = Tmax_data + 0.1*(Tmax_data - Tmin_data);
Tmin = Tmin_data - 0.1*(Tmax_data - Tmin_data);

axis([Smin Smax Tmin Tmax]);

end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% orient tall
% print -djpeg E4_C10

% ax1 = gca;
% ax2 = axes('Position',get(ax1,'Position'));
% set(gca,'XAxisLocation','top')
% set(gca,'XTickMode','manual','XTick',fliplr(x),'TickDir','out','XGrid','on','GridLineStyle',':','Layer','top')
% set(gca,'XTickLabel',[fliplr(lance)],'FontSize',7)
% hc=colorbar; set(hc,'CLim',[cmin cmax])

% hl1 = line(x,x,'Color','k'); 
% ax1 = gca;
% set(ax1,'XColor','k','YColor','k')
% ax2 = axes('Position',get(ax1,'Position'),'XAxisLocation','top',...
%     'YAxisLocation','right','Color','none','XColor','k','YColor','k');
% hl2 = line(lance,x,'Color','k','Parent',ax2);
% line('XData',lance)
% set
% get
% gca

% set(gca,'XTickMode','auto')
% set(gca,'XTickMode','manual','XTick',fliplr(x))
