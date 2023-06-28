% Carga los archivos de datos y calcula la distancia máxima de las lineas
% de muestreo en cada crucero, y los valores maximos y minimos de las 
% variables hidrograficas.
% (Load data files and calculate the maximum distance of the sample lines
% in each cruise. Also, calculates the min and max value for each variable.)

clear
tic
distancia = []; cruc = 0;
for k = [2:4 6 8:10]
    cruc = cruc + 1;  dist = []; 
    if k <= 9; crucero = ['lineasBTS0',num2str(k)]; load(crucero); end
    if k > 9;  crucero = ['lineasBTS',num2str(k)]; load(crucero); end
    for linea = 1:length(E)
    
        lon    = E(linea).lon; 
        lat    = E(linea).lat;
        lance  = E(linea).lance;
        date   = E(linea).fecha;                 % fecha del lance (aa.mm.dd.hh.mn.ss)
        S      = E(linea).S;                     % salinidad (ups)
        T      = E(linea).T;                     % temperatura (°C)
        O2     = E(linea).O2;                    % oxigeno disuelto (ml/L)
        D      = E(linea).D;                     % densidad (kg/m3)
        Chla   = E(linea).Chla;                  % clorofila
        SA = gsw_SA_from_SP(S,P,lon,lat);        % Salinidad absoluta
        TC = gsw_CT_from_t(SA,T,P);              % Temperatura conservativa
        DP = gsw_pot_rho_t_exact(SA,T,P,0)-1000; % Anomalia densidad potencial p_ref=0 'Sigma 0'
        TP = gsw_pt0_from_t(SA,T,0);             % Temperatura potencial.                
        Sp = spice(0,TP,SA);                     % 'Spiciness'
 
        if isempty(lon), continue
        else dis = sw_dist([lat(1) lat(end)],[lon(1) lon(end)],'km'); dist = [dist dis];
        end
        
        % Maximos y Minimos de Linea
        mnmx_S(linea,:) = [min(S(:)) max(S(:))];
        mnmx_T(linea,:) = [min(T(:)) max(T(:))];
        mnmx_O2(linea,:) = [min(O2(:)) max(O2(:))];
        mnmx_D(linea,:) = [min(D(:)) max(D(:))];
        mnmx_Chla(linea,:) = [min(Chla(:)) max(Chla(:))];
        mnmx_SA(linea,:) = [min(SA(:)) max(SA(:))];
        mnmx_TC(linea,:) = [min(TC(:)) max(TC(:))];
        mnmx_DP(linea,:) = [min(DP(:)) max(DP(:))];
        mnmx_TP(linea,:) = [min(TP(:)) max(TP(:))];
        mnmx_Sp(linea,:) = [min(Sp(:)) max(Sp(:))];
        
        % Maximos y Minimos de Anomalias por Linea
        anmS = anom_var(S,P); mnmx_anmS(linea,:) = [min(anmS(:)) max(anmS(:))];
        anmT = anom_var(T,P); mnmx_anmT(linea,:) = [min(anmT(:)) max(anmT(:))];
        anmO2 = anom_var(O2,P); mnmx_anmO2(linea,:) = [min(anmO2(:)) max(anmO2(:))];
        anmD = anom_var(D,P); mnmx_anmD(linea,:) = [min(anmD(:)) max(anmD(:))];
        anmChla = anom_var(Chla,P); mnmx_anmChla(linea,:) = [min(anmChla(:)) max(anmChla(:))];
        anmSA = anom_var(SA,P); mnmx_anmSA(linea,:) = [min(anmSA(:)) max(anmSA(:))];
        anmTC = anom_var(TC,P); mnmx_anmTC(linea,:) = [min(anmTC(:)) max(anmTC(:))];
        anmDP = anom_var(DP,P); mnmx_anmDP(linea,:) = [min(anmDP(:)) max(anmDP(:))];
        anmTP = anom_var(TP,P); mnmx_anmTP(linea,:) = [min(anmTP(:)) max(anmTP(:))];
        anmSp = anom_var(Sp,P); mnmx_anmSp(linea,:) = [min(anmSp(:)) max(anmSp(:))];
        
    end
     
    distancia = [distancia max(dist)];
 
    % Maximos y Minimos de Crucero
    minmax_S(cruc,:) = [min(mnmx_S(:)) max(mnmx_S(:))];    minmax_T(cruc,:) = [min(mnmx_T(:)) max(mnmx_T(:))];
    minmax_O2(cruc,:) = [min(mnmx_O2(:)) max(mnmx_O2(:))]; minmax_D(cruc,:) = [min(mnmx_D(:)) max(mnmx_D(:))];
    minmax_SA(cruc,:) = [min(mnmx_SA(:)) max(mnmx_SA(:))]; minmax_Chla(cruc,:) = [min(mnmx_Chla(:)) max(mnmx_Chla(:))];
    minmax_TC(cruc,:) = [min(mnmx_TC(:)) max(mnmx_TC(:))]; minmax_DP(cruc,:) = [min(mnmx_DP(:)) max(mnmx_DP(:))];
    minmax_TP(cruc,:) = [min(mnmx_TP(:)) max(mnmx_TP(:))]; minmax_Sp(cruc,:) = [min(mnmx_Sp(:)) max(mnmx_Sp(:))];
    
    minmax_anmS(cruc,:) = [min(mnmx_anmS(:)) max(mnmx_anmS(:))]; minmax_anmT(cruc,:) = [min(mnmx_anmT(:)) max(mnmx_anmT(:))];
    minmax_anmO2(cruc,:) = [min(mnmx_anmO2(:)) max(mnmx_anmO2(:))]; minmax_anmD(cruc,:) = [min(mnmx_anmD(:)) max(mnmx_anmD(:))];
    minmax_anmSA(cruc,:) = [min(mnmx_anmSA(:)) max(mnmx_anmSA(:))]; minmax_anmChla(cruc,:) = [min(mnmx_anmChla(:)) max(mnmx_anmChla(:))];
    minmax_anmTC(cruc,:) = [min(mnmx_anmTC(:)) max(mnmx_anmTC(:))]; minmax_anmDP(cruc,:) = [min(mnmx_anmDP(:)) max(mnmx_anmDP(:))];
    minmax_anmTP(cruc,:) = [min(mnmx_anmTP(:)) max(mnmx_anmTP(:))]; minmax_anmSp(cruc,:) = [min(mnmx_anmSp(:)) max(mnmx_anmSp(:))];
    
    clear mnmx_S mnmx_T mnmx_O2 mnmx_D mnmx_SA mnmx_TC mnmx_DP mnmx_TP mnmx_Sp mnmx_Chla...
          mnmx_anmS mnmx_anmT mnmx_anmO2 mnmx_anmD mnmx_anmSA mnmx_anmTC mnmx_anmDP mnmx_anmTP mnmx_anmSp mnmx_anmChla
end

% Maximos y Minimos de TODOS los Cruceros
minmax_S  = [min(minmax_S(:)) max(minmax_S(:))];
minmax_T  = [min(minmax_T(:)) max(minmax_T(:))];
minmax_O2 = [min(minmax_O2(:)) max(minmax_O2(:))];
minmax_D  = [min(minmax_D(:)) max(minmax_D(:))];
minmax_Chla = [min(minmax_Chla(:)) max(minmax_Chla(:))];
minmax_SA = [min(minmax_SA(:)) max(minmax_SA(:))];
minmax_TC = [min(minmax_TC(:)) max(minmax_TC(:))]; 
minmax_DP = [min(minmax_DP(:)) max(minmax_DP(:))];
minmax_TP = [min(minmax_TP(:)) max(minmax_TP(:))]; 
minmax_Sp = [min(minmax_Sp(:)) max(minmax_Sp(:))];

minmax_anmS = [min(minmax_anmS(:)) max(minmax_anmS(:))]; 
minmax_anmT = [min(minmax_anmT(:)) max(minmax_anmT(:))];
minmax_anmO2 = [min(minmax_anmO2(:)) max(minmax_anmO2(:))]; 
minmax_anmD= [min(minmax_anmD(:)) max(minmax_anmD(:))];
minmax_anmChla = [min(minmax_anmChla(:)) max(minmax_anmChla(:))];
minmax_anmSA = [min(minmax_anmSA(:)) max(minmax_anmSA(:))]; 
minmax_anmTC = [min(minmax_anmTC(:)) max(minmax_anmTC(:))];
minmax_anmDP = [min(minmax_anmDP(:)) max(minmax_anmDP(:))];
minmax_anmTP = [min(minmax_anmTP(:)) max(minmax_anmTP(:))];
minmax_anmSp = [min(minmax_anmSp(:)) max(minmax_anmSp(:))];

toc