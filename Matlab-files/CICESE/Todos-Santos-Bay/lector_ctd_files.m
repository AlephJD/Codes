% Carga datos de CTD de los crucero BTS
% (Load CTD data from BTS cruises, and find flag values.)

% 2(sub), 3(baj), 4(baj), 6(sub), 8(baj), 9(sub), 10(baj).

% Realizado por: Aleph Jimenez
% Para: CICESE
% Fecha 22.10.2011

clear
for cruc = 10 %[2:4 6 8:10]

files = dir(['C:\Users\Aleaph\CICESE Job\Datos\Base Datos Preprocesados\ctdbts',num2str(cruc),'\baj*']);
hdr = load(['poctdBTS',num2str(cruc),'.txt']);

lat = hdr(:,2) + hdr(:,3)/60; lon = -abs(hdr(:,4) + hdr(:,5)/60);
profmax = hdr(:,6); Pmax = hdr(:,7); P = [1:max(Pmax)]';
fecha = hdr(:,[13 12 11 8 9 10]);
lan = hdr(:,1);

for n = 1:length(files)
    dat = load(['ctdbts',num2str(cruc),'\' files(n).name]);
    
    % Encuentra valores bandera (99.0000 o 99.9999)
    % (Find flag values)
    ind = find(dat(:,3) < 99); sa = gsw_SA_from_SP(dat(ind,3),dat(ind,1),lon(n),lat(n));
                               if ~isempty(ind) && length(ind) >= 2; SA(:,n) = interp1(dat(ind,1),sa,P);           else   SA(:,n) = NaN*ones(length(P),1); end;
                               if ~isempty(ind) && length(ind) >= 2; S(:,n) = interp1(dat(ind,1),dat(ind,3),P);    else    S(:,n) = NaN*ones(length(P),1); end;
    ind = find(dat(:,2) < 99); sa = gsw_SA_from_SP(dat(ind,3),dat(ind,1),lon(n),lat(n)); tc = gsw_CT_from_t(sa,dat(ind,2),dat(ind,1));
                               if ~isempty(ind) && length(ind) >= 2; TC(:,n) = interp1(dat(ind,1),tc,P);           else   TC(:,n) = NaN*ones(length(P),1); end;
                               if ~isempty(ind) && length(ind) >= 2; T(:,n) = interp1(dat(ind,1),dat(ind,2),P);    else    T(:,n) = NaN*ones(length(P),1); end;
    ind = find(dat(:,4) < 99); if ~isempty(ind) && length(ind) >= 2; O2(:,n) = interp1(dat(ind,1),dat(ind,4),P);   else   O2(:,n) = NaN*ones(length(P),1); end;
    ind = find(dat(:,6) < 99); if ~isempty(ind) && length(ind) >= 2; Chla(:,n) = interp1(dat(ind,1),dat(ind,6),P); else Chla(:,n) = NaN*ones(length(P),1); end;

    s = dat(:,3); ind = find(s >= 99); s(ind) = NaN; sa = gsw_SA_from_SP(s,dat(:,1),lon(n),lat(n));
    t = dat(:,2); ind = find(t >= 99); t(ind) = NaN; tc = gsw_CT_from_t(sa,t,dat(:,1));
                                                      d = gsw_rho_CT_exact(sa,tc,dat(:,1)); dp = gsw_rho_CT_exact(sa,tc,0)-1000; 
                                                     tp = gsw_pt0_from_t(sa,t,0); sp = spice(0,tp,sa);
    nonan = find(~isnan(d));   if ~isempty(nonan) && length(nonan) >= 2;  D(:,n) = interp1(dat(nonan,1),d(nonan),P); 
                                                                         DP(:,n) = interp1(dat(nonan,1),dp(nonan),P);
                                                                         TP(:,n) = interp1(dat(nonan,1),tp(nonan),P); 
                                                                         Sp(:,n) = interp1(dat(nonan,1),sp(nonan),P);
                               else D(:,n) = NaN*ones(length(P),1); DP(:,n) = NaN*ones(length(P),1);
                                   TP(:,n) = NaN*ones(length(P),1); Sp(:,n) = NaN*ones(length(P),1);
                               end;
   
end % for n

    figure(1); hold on
    plot(S,T); xlabel('S [ups]'); ylabel('T [ºC]'); title(['BTS',num2str(cruc)]);axis square

    figure(2); hold on
    plot(S,P); set(gca,'YDir','reverse');
    xlabel('Salinidad [ups]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square
    
    figure(3); hold on
    plot(T,P); set(gca,'YDir','reverse');
    xlabel('Temperatura [ºC]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square
    
    figure(4); hold on
    plot(O2,P); set(gca,'YDir','reverse');
    xlabel('Oxígeno Disuelto [ml{\cdot}L^-^1]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square
    
    figure(5); hold on
    plot(D,P); set(gca,'YDir','reverse');
    xlabel('Anomalía de Densidad potencial [kg{\cdot}m^-^3]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square
    
    figure(6); hold on
    plot(Chla,P); set(gca,'YDir','reverse');
    xlabel('Clorofila "a" [µ{\cdot}L^-^1]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square

end
