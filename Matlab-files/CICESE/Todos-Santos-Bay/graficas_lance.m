% Grafica los perfiles de las variables hidrograficas por lance de cada 
% linea por crucero.

clear
load lineasBTS04

for linea = 4 %1:5
    
    lance = E(linea).lance;
    S     = E(linea).S;
    T     = E(linea).T;
    O2    = E(linea).O2;
    D     = E(linea).D;
    Chla  = E(linea).Chla;
    
    for est = 1 %:length(lance)
        figure(est)
        for ind = length(P):-1:0; nonan = find(~isnan(S(ind,est)));
            if ~isempty(nonan); break; end
        end
        plot(S(1:ind,est),P(1:ind),'r')%,T(1:ind,est),P(1:ind),'b',O2(1:ind,est),P(1:ind),'k',...
%              D(1:ind,est),P(1:ind),'g',Chla(1:ind,est),P(1:ind),'m')
        set(gca,'YDir','reverse');
        ylabel('Presión [dbar]'); xlabel('Salinidad (ups)')
        title(['BTS6 linea E',num2str(linea),', Lance ',num2str(lance(est))])
    end
       
end

load lineasBTS2nuevas;
S=E(1).S(:,2);
T=E(1).T(:,2);
O2=E(1).O2(:,2);
D=E(1).D(:,2);
Chla=E(1).Chla(:,2);

hl1=line(S(1:1000),P(1:1000),'Color','r'); 
set(gca,'YDir','reverse');
ax1=gca;
set(ax1,'XColor','r','YColor','r');
text(34.65,1000,['S [ups]'],'HorizontalAlignment','right');
axis square

ax2=axes('Position',get(ax1,'Position'),...
         'XAxisLocation','bottom',...
         'YAxisLocation','left',...
         'Color','none',...
         'XColor','k','YColor','k');
hl2=line(T(1:1000),P(1:1000),'Color','b','Parent',ax2);
set(gca,'YDir','reverse');
ylabel('Pressure [dbar]');
text(17.5,1000,['T [ºC]'],'HorizontalAlignment','right');
axis square

xlimits=get(ax1,'XLim');
ylimits=get(ax1,'YLim');
xinc=(xlimits(2)-xlimits(1))/8;
yinc=(ylimits(2)-ylimits(1))/10;
set(ax1,'Xtick',[xlimits(1):xinc:xlimits(2)],...
        'YTick',[ylimits(1):yinc:ylimits(2)]);

xlimits=get(ax2,'XLim');
ylimits=get(ax2,'YLim');
xinc=(xlimits(2)-xlimits(1))/8;
yinc=(ylimits(2)-ylimits(1))/10;
set(ax2,'Xtick',[xlimits(1):xinc:xlimits(2)],...
        'YTick',[ylimits(1):yinc:ylimits(2)]);

set(gca,'Position',[0 0 2 2],'Color','k')

