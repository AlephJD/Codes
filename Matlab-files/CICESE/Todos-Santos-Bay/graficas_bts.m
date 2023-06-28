% Grafica los datos 'in situ' recabados en los cruceros BTS's por lineas
% de muestreo.

clear

for k = 9 %[2:4 6 8:10]
    % carga lineas de crucero
    crucero = ['lineasBTS',num2str(k),'nuevas']; load(crucero);
    for linea = 1 %:length(E)
        %% Variables
        % Ordena las coordenadas de Este a Oeste (derecha a izquierda en la matriz)
        lon = E(linea).lon'; lat = E(linea).lat';
        [s,orden] = sort(lon,'descend'); orden = fliplr(orden);
        lon = lon(orden); lat =lat(orden);
        
        lance    = E(linea).lance(orden);
        date     = E(linea).fecha(orden,:);    % fecha del lance (aa.mm.dd.hh.mn.ss)
        S        = E(linea).S(:,orden);        % salinidad (ups)
        T        = E(linea).T(:,orden);        % temperatura (?C)
        O2       = E(linea).O2(:,orden);       % oxigeno disuelto (ml/L)
        D        = E(linea).D(:,orden);        % densidad (kg/m3)
%         Chla     = E(linea).Chla(orden);       % clorofila
%         plance   = E(linea).plance(:,orden);   % profundidad de lance (m)
%         pdbar    = E(linea).pdbar(:,orden);    % presion (dbar)
%         Um       = E(linea).Um(:,orden);       % componente 'x' de la velocidad de LADCP
%         Vm       = E(linea).Vm(:,orden);       % componente 'y' de la velocidad de LADCP
%         lonLADCP = E(linea).lonLADCP(:,orden); % coordenada 'x' de la velocidad de LADCP
%         latLADCP = E(linea).latLADCP(:,orden); % coordenada 'y' de la velocidad de LADCP
                                               % P(profundidad en m)
                                           
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
 
        figure
        for vars = 1:4
            switch vars
            case 1; var = S;  cmin = min(S(:));  cmax = max(S(:));
            case 2; var = T;  cmin = min(T(:));  cmax = max(T(:));
            case 3; var = O2; cmin = min(O2(:)); cmax = max(O2(:));
            case 4; var = D;  cmin = min(D(:));  cmax = max(D(:));
            end
             
            subplot(2,2,vars); pcolor(x,P,var); shading interp; caxis([cmin cmax]); colorbar;
            set(gca,'XDir','reverse','YDir','reverse'); 
%             ax1 = gca; set(ax1,'XColor','k','YColor','k')
%             ax2 = axes('Position',get(ax1,'Position'),'XAxisLocation','top',...
%                 'YAxisLocation','none','Color','none','XColor','k','YColor','k');
%             hold on; plot(x)
            xlabel('Distancia (km)'); ylabel('Presi?n (dbar)');
            if vars == 1; title(['Crucero ',num2str(k),' Linea ',num2str(linea), '  S [ups]'])
            elseif vars == 2; title(['Crucero ',num2str(k),' Linea ',num2str(linea), '  T [?C]'])
            elseif vars == 3; title(['Crucero ',num2str(k),' Linea ',num2str(linea), '  O2 [ml{\cdot}L^-^1]'])
            elseif vars == 4; title(['Crucero ',num2str(k),' Linea ',num2str(linea), '  D [kg{\cdot}m^-^3]'])
            end
            %make_ground_section(x,P,)
        end
    end
end
                                            

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

ax1 = gca;
ax2 = axes('Position',get(ax1,'Position'));
set(gca,'XAxisLocation','top')
set(gca,'XTickMode','manual','XTick',fliplr(x),'TickDir','out','XGrid','on','GridLineStyle',':','Layer','top')
set(gca,'XTickLabel',[fliplr(lance)],'FontSize',7)
hc=colorbar; set(hc,'CLim',[cmin cmax])