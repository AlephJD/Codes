% Diagrama T/S para informes BTS usando datos directos de crucero 
% (Temperature and salinity diagrams for BTS's reports using cruise direct 
% data.)

% Realizado por: Aleph Jimenez
% Para: CICESE

clear
cruc = 10;

files = dir(['C:\Users\Aleaph\CICESE Job\Datos\Datos Cruceros Preprocesados\bts',num2str(cruc),'\lan*']);
for n = 1:length(files)
    dat = load(['bts',num2str(cruc),'\' files(n).name]);
    dbar(n) = max(dat(:,2)); ind = find(dbar(n) == dat(:,2));
    
    Sb = dat(1:ind,14); Ss = dat(ind:end,14);
    Tb = dat(1:ind,3);  Ts = dat(ind:end,3);
    
    ind = find(max(Sb)); Sb(ind) = NaN; ind = find(min(Sb)); Sb(ind) = NaN;
    ind = find(max(Ss)); Ss(ind) = NaN; ind = find(min(Ss)); Ss(ind) = NaN;
    ind = find(max(Tb)); Tb(ind) = NaN; ind = find(min(Tb)); Tb(ind) = NaN;
    ind = find(max(Ts)); Ts(ind) = NaN; ind = find(min(Ts)); Ts(ind) = NaN;    
    
    % BAJADA (DOWN)
    Sb_m = nanmean(Sb); Sb_std = nanstd(Sb);
    Tb_m = nanmean(Tb); Tb_std = nanstd(Tb);
    
    Sb_min = Sb_m - 2*Sb_std; Sb_max = Sb_m + 2*Sb_std;
    S_ind1 = find(Sb < Sb_min); S_ind2 = find(Sb > Sb_max); 
    Tb_min = Tb_m - 2*Tb_std; Tb_max = Tb_m + 2*Tb_std;
    T_ind1 = find(Tb < Tb_min); T_ind2 = find(Tb > Tb_max);     
    
    if ~isempty(S_ind1); Sb(S_ind1) = NaN; end
    if ~isempty(S_ind2); Sb(S_ind2) = NaN; end
    if ~isempty(T_ind1); Tb(T_ind1) = NaN; end
    if ~isempty(T_ind2); Tb(T_ind2) = NaN; end    

    % SUBIDA (UP)
    Ss_m = nanmean(Ss); Ss_std = nanstd(Ss);
    Ts_m = nanmean(Ts); Ts_std = nanstd(Ts);
    
    Ss_min = Ss_m - 2*Ss_std; Ss_max = Ss_m + 2*Ss_std;
    S_ind1 = find(Ss < Ss_min); S_ind2 = find(Ss > Ss_max); 
    Ts_min = Ts_m - 2*Ts_std; Ts_max = Ts_m + 2*Ts_std;
    T_ind1 = find(Ts < Ts_min); T_ind2 = find(Ts > Ts_max);     
    
    if ~isempty(S_ind1); Ss(S_ind1) = NaN; end
    if ~isempty(S_ind2); Ss(S_ind2) = NaN; end
    if ~isempty(T_ind1); Ts(T_ind1) = NaN; end
    if ~isempty(T_ind2); Ts(T_ind2) = NaN; end    
    
    figure(1); hold on
    plot(Sb,Tb,'.b')
    ylabel('Temperatura (ºC)'); xlabel('Salinidad (ups)')
    figure(2); hold on
    plot(Ss,Ts,'.b')
    ylabel('Temperatura (ºC)'); xlabel('Salinidad (ups)')
end

