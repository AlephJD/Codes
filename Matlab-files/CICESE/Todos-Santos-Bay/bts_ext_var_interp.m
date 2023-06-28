% Genera matrices de interpolacion de variables hidrograficas de las campanias
% BTS's para la region externa a la Bahia de Todos Santos.

% Realizado por: Aleph Jimenez
% Para: CICESE
% Fecha 30.09.2011

clear
tic
% Distanciamento(m) de los puntos a interpolar sobre una recta ficticia en la horizontal
dr = 500;
% Distanciamento(kg/m3) de los puntos a interpolar sobre una recta ficticia en la densidad
dD = (30-15)/50; di = [15:dD:30]';

glat2m = 111194.93;    % 1?lat = 111,194.93 m (para una Tierra esferica de Radio(R) = 6,371,000 m)
mlat2m = 1853.25;      % 1'lat = 1853.2488 m = 1 m.n. (para una Tierra esferica de Radio(R) = 6,371,000 m)
slat2m = 30.89;        % 1"lat = 30.8875 m   = 1/60 m.n. (para una Tierra esferica de Radio(R) = 6,371,000 m)

cruc = 0;
for k = [2:4 6 8:10]
    cruc = cruc + 1;
    % carga lineas de crucero
    if k <=9; crucero = ['lineasBTS0',num2str(k)]; load(crucero); end
    if k >9;  crucero = ['lineasBTS',num2str(k)]; load(crucero); end
    for linea = 1:length(E)
        %% Variables
        % Ordena las coordenadas de Este a Oeste (derecha a izquierda en la matriz)
        lon = E(linea).lon'; lat = E(linea).lat';
        [s,orden] = sort(lon,'descend'); orden = fliplr(orden);
        lon = lon(orden); lat =lat(orden);
        
        lance =  E(linea).lance(orden);
        fecha =  E(linea).fecha(orden,:);    % fecha del lance (aa.mm.dd.hh.mn.ss)
        S =      E(linea).S(:,orden);        % salinidad in situ (ups)
        T =      E(linea).T(:,orden);        % temperatura in situ (?C)
        O2 =     E(linea).O2(:,orden);       % oxigeno disuelto (ml/L)
        D =      E(linea).D(:,orden);        % densidad in situ (kg/m3) 
        Chla =   E(linea).Chla(:,orden);     % clorofila (?/L)
%         plance = E(linea).plance(:,orden);   % profundidad de lance (m)
%         pdbar =  E(linea).pdbar(:,orden);    % presion (dbar)
                                             % P(profundidad en m)
        
        % Calculando la  Anomalia de Densidad Potencial
        SA = gsw_SA_from_SP(S,P,lon,lat); TC = gsw_CT_from_t(SA,T,P);
        
        DP = gsw_rho_CT_exact(SA,TC,0)-1000;
        
        % Para interpolar con respecto a la 'Densidad'
        for ind = 1:length(lance)
            [DP(:,ind),orden] = sort(DP(:,ind),'ascend');
            S_den(:,ind)      = S(orden,ind);
            T_den(:,ind)      = T(orden,ind);
            O2_den(:,ind)     = O2(orden,ind);
            D_den(:,ind)      = D(orden,ind);
            Chla_den(:,ind)   = Chla(orden,ind);
            P_den(:,ind)      = P(orden); 
        end
        
        % Calcula el angulo entre la 1er. y ultima estacion de la linea de muestreo 
        % (de Este a Oeste) para generar una recta ficticia de distancia 'dfm' donde interpolar
        [distance,angle] = sw_dist([lat(end) lat(1)],[lon(end) lon(1)],'km');
        % Encuentra las distancias de separacion entre estaciones de muestreo
        [dist,angles] = sw_dist(lat,lon,'km'); dist = dist*1000;
        
        dfm = distance*1000; ri = [0 dr:dr:dfm]; 
        if ~any(ri==dfm); ri = [ri dfm]; end; ri = fliplr(ri);
        
        % Encuentra distancias 'x' y 'y' de las coordenadas geograficas de los
        % puntos de muestreo
        alphas = angles.*pi/180;
        y = dist.*sin(alphas); y_neg = find(y < 0);
        if ~isempty(y_neg); y(y_neg) = y(y_neg)* - 1; else
        end % ~isempty(y_neg)
        x = sqrt(dist.^2 - y.^2);
        x = [0 cumsum(x(end:-1:1))]; x = x/1000; x = fliplr(x); % y = [0;cumsum(y(end:-1:1))];  y = y/1000; y = fliplr(y);

        % Encuentra distancias 'x' y 'y' de los puntos de interpolacion sobre la recta ficticia
        alpha = angle*pi/180;
        yi = ri*sin(alpha);
        xi = sqrt(ri.^2 - yi.^2);

        % Calcula la equivalencia de 1 grado de longitud a una latitud dada
        latmed = (lat(1) + lat(end))/2; radian = latmed*pi/180;
        lonEqlat = cos(radian); lonEqlat = lonEqlat*mlat2m; 
        glon2m = lonEqlat*60; 

        % Obtiene las coordenadas geograficas sobre las cuales estan localizados
        % los puntos de interpolacion (x,y) sobre la recta ficticia.
        dgx = xi./glon2m; dgy = yi./glat2m;
        lons = lon(end) - dgx; lats = lat(end) + dgy;       % el signo de [lats = lat(end) (+) dgy], depende desde que estacion
        xi = xi/1000; yi = yi/1000;                         % se mida el angulo de
                                                            % apertura y desde que estacion se comience a realizar la suma de
                                                            % diferencias.

        % Calcula la interpolacion de las variables en los puntos sobre la recta
        % a los niveles de presion
         for vars = 1:6 
            switch vars
                case 1; var = fecha; 
                case 2; var = S;     var2 = S_den; var3 = P_den;
                case 3; var = T;     var2 = T_den;
                case 4; var = O2;    var2 = O2_den;
                case 5; var = D;     var2 = D_den;
                case 6; var = Chla;  var2 = Chla_den;
%                 case 7; var = pdbar;
%                 case 8; var = plance;
            end
            
            if vars < 2
                if vars == 1; var = datenum(var); nonan = find(~isnan(var));
                %else nonan = find(~isnan(var));
                end % if vars == 1
                if ~isempty(nonan) && length(nonan) >= 2
                    var_interp(vars).var = interp1(x(nonan),var(nonan),xi);
                else
                    var_interp(vars).var = NaN*xi;
                end % if ~isempty(nonan) && length(nonan) >= 2
            elseif vars >= 2
                for z = 1:length(P)
                    nonan = find(~isnan(var(z,:)));
                    if ~isempty(nonan) && length(nonan) >= 2  % ~isempty(var(z,nonan)) & length(var(z,nonan)) >= 2
                        var_interp(vars).var(z,:) = interp1(x(nonan),var(z,nonan),xi);
                        for i = 1:length(nonan) - 1
                            diff = abs(nonan(i) - nonan(i+1));
                            if diff > 1; 
                                a = x(nonan(i)) > xi & xi > x(nonan(i+1));
                                var_interp(vars).var(z,a) = NaN;
                            end
                        end
                    elseif ~isempty(nonan) && length(nonan) == 1
                        var_interp(vars).var(z,:) = NaN*ones(1,length(xi));
                        a = x(nonan) == xi;
                        if ~isempty(a)
                        var_interp(vars).var(z,a) = var(z,nonan);
                        end
                    else
                        var_interp(vars).var(z,:) = NaN*ones(1,length(xi));
                    end % if ~isempty(nonan) & length(nonan) >= 2
                end % for z = 1:length(P)
                % INTERPOLACION RESPECTO A DENSIDAD
                for xx = 1:length(x)
                    nonan2 = find(~isnan(DP(:,xx)));
                    if ~isempty(nonan2) && length(nonan2) >= 2
                        if vars == 2
                        var_interp_den(vars-1).var2(:,xx) = interp1(DP(nonan2,xx),var3(nonan2,xx),di);
                        end
                        var_interp_den(vars).var2(:,xx) = interp1(DP(nonan2,xx),var2(nonan2,xx),di);
                         for i = length(nonan2)-1
                             diff = abs(nonan2(i) - nonan2(i+1));
                             if diff > 1;
                                 a = DP(nonan2(i),xx) > di & di > DP(nonan2(i+1),xx);
                                 if vars == 2
                                 var_interp_den(vars-1).var2(a,xx) = NaN;
                                 end
                                 var_interp_den(vars).var2(a,xx) = NaN;
                             end
                         end
                    elseif ~isempty(nonan2) &&  length(nonan2) == 1
                        if vars == 2
                        var_interp_den(vars-1).var2(:,xx) = NaN*ones(length(di),1);
                        end
                        var_interp_den(vars).var2(:,xx) = NaN*ones(length(di),1);
                        a = DP(nonan2) == di;
                        if ~isempty(a)
                        if vars == 2
                        var_interp_den(vars-1).var2(a,xx) = var3(nonan2,xx);
                        end
                        var_interp_den(vars).var2(a,xx) = var2(nonan2,xx);
                        end
                    else
                        if vars == 2
                        var_interp_den(vars-1).var2(:,xx) = NaN*ones(length(di),1);
                        end
                        var_interp_den(vars).var2(:,xx) = NaN*ones(length(di),1);
                    end % ~isempty(nonan2) && length(nonan2) >= 2
                end % xx = 1:length(x)
            end % if vars < 2
            clear var nonan nonan2
        end % for vars = 1:6
        
        bts_ext(cruc,linea).lance = lance;
        bts_ext(cruc,linea).fecha = fecha;
        bts_ext(cruc,linea).x = x;        
        bts_ext(cruc,linea).lon = lon;
        bts_ext(cruc,linea).lat = lat;
        bts_ext(cruc,linea).S = S;
        bts_ext(cruc,linea).T = T;
        bts_ext(cruc,linea).O2 = O2;
        bts_ext(cruc,linea).D = D;
        bts_ext(cruc,linea).P = P;
        bts_ext(cruc,linea).fechai = var_interp(1).var;
        bts_ext(cruc,linea).xi = xi;
        bts_ext(cruc,linea).loni = lons;
        bts_ext(cruc,linea).lati = lats;
%         bts_ext(cruc,linea).plance = var_interp(2).var;
%         bts_ext(cruc,linea).pdbar = var_interp(3).var;
        bts_ext(cruc,linea).Si = var_interp(2).var;                                                      % Salinidad
        bts_ext(cruc,linea).Ti = var_interp(3).var;                                                      % Temperatura
        bts_ext(cruc,linea).O2i = var_interp(4).var;                                                     % Oxigeno Disuelto
        bts_ext(cruc,linea).Di = var_interp(5).var;                                                      % Densidad
        bts_ext(cruc,linea).Chlai = var_interp(6).var;                                                    % Clorofila 'a'

        % DATOS INTERPOLADOS A DENSIDAD
        bts_ext_den(cruc,linea).P_den = var_interp_den(1).var2;
        bts_ext_den(cruc,linea).S_den = var_interp_den(2).var2;
        bts_ext_den(cruc,linea).T_den = var_interp_den(3).var2;
        bts_ext_den(cruc,linea).O2_den = var_interp_den(4).var2;
        bts_ext_den(cruc,linea).D_den = var_interp_den(5).var2;
        bts_ext_den(cruc,linea).Chla_den = var_interp_den(6).var2;
        
        clear lon lat orden lance date S T O2 D Chla DP S_den T_den O2_den... 
              D_den Chla_den P_den distance angle dist angles alphas x y... 
              alpha xi yi latmed radian lonEqlat glon2m dgx dgy lons lats... 
              var var_interp var_interp_den     % plance pdbar
    end % for linea = 1:length(E)
    clear E P
end % for k = [2:4 6 8:10]

toc
% save bts_ext.mat

readme.lance = ['No. de lance de acuerdo a crucero'];
readme.fecha = ['Fecha del lance de acuerdo a crucero'];
readme.fechai = ['Fecha de los puntos calculados mediante interpolacion'];
readme.x = ['Distancia de los lances respecto al eje X (km)'];
readme.xi = ['Distancia de los puntos de interpolacion respecto al eje X (km)'];
readme.lon = ['Coordenada geografica del lance en la longitud'];
readme.loni = ['Coordenada geografica de los puntos de interpolacion en la longitud'];
readme.lat = ['Coordenada geografica del lance en la latitud'];
readme.lati = ['Coordenada geografica de los puntos de interpolacion en la latitud'];
readme.S = ['Salinidad in situ'];
readme.Si = ['Salinidad calculada mediante interpolacion respecto al plano xy'];
readme.S_den = ['Salinidad calculada mediante interpolacion respecto a la densidad'];
readme.T = ['Temperatura in situ'];
readme.Ti = ['Temperatura calculada mediante interpolacion respecto al plano xy'];
readme.T_den = ['Temperatura calculada mediante interpolacion respecto a la densidad'];
readme.O2 = ['Oxigeno in situ'];
readme.O2i = ['Oxigeno calculada mediante interpolacion respecto al plano xy'];
readme.O2_den = ['Oxigeno calculada mediante interpolacion respecto a la densidad'];
readme.D = ['Densidad in situ'];
readme.Di = ['Densidad calculada mediante interpolacion respecto al plano xy'];
readme.D_den = ['Densidad calculada mediante interpolacion respecto a la densidad'];
readme.Chla = ['Clorofila in situ'];
readme.Chlai = ['Clorofila calculada mediante interpolacion respecto al plano xy'];
readme.Chla_den = ['Clorofila calculada mediante interpolacion respecto a la densidad'];
readme.P = ['Presion de la columna de agua'];
readme.P_den = ['Presion calculada mediante interpolacion respecto a la densidad'];
