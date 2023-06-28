% Calcula los promedios y anomalias generales y estacionales de las lineas de muestreo
% realizados en los cruceros BTS's.

close all
load bts_ext

n = size(bts_ext);
m = n(1); n = n(2);
% Para los promedios NO se tomara en  cuenta el crucero BTS1, y se inicia
% desde el crucero BTS2.
inv = 1; prim = inv; ver = inv; oto = inv;

for cruc = 1:m
    for linea = 1:n
        % Se restringe la matriz a la profundidad de 1000 dbar
        fecha(:,:,cruc,linea) = bts_ext(cruc,linea).datei;
        xi(:,:,cruc,linea)    = bts_ext(cruc,linea).xi;
        lon(:,:,cruc,linea)   = bts_ext(cruc,linea).loni;
        lat(:,:,cruc,linea)   = bts_ext(cruc,linea).lati;
        S(:,:,cruc,linea)     = bts_ext(cruc,linea).S(1:1000,:);
        T(:,:,cruc,linea)     = bts_ext(cruc,linea).T(1:1000,:);
        O2(:,:,cruc,linea)    = bts_ext(cruc,linea).O2(1:1000,:);
        D(:,:,cruc,linea)     = bts_ext(cruc,linea).D(1:1000,:);
        P                     = bts_ext(cruc,linea).P(1:1000);
        SA(:,:,cruc,linea)    = gsw_SA_from_SP(S(:,:,cruc,linea),P,lon(:,:,cruc,linea),lat(:,:,cruc,linea));    % Salinidad absoluta
        TC(:,:,cruc,linea)    = gsw_CT_from_t(SA(:,:,cruc,linea),T(:,:,cruc,linea),P);                          % Temperatura conservativa
        DP(:,:,cruc,linea)    = gsw_pot_rho_t_exact(SA(:,:,cruc,linea),T(:,:,cruc,linea),P,0);                  % Densidad potencial
        TP(:,:,cruc,linea)    = gsw_pt_from_CT(SA(:,:,cruc,linea),TC(:,:,cruc,linea));                          % Temperatura potencial                
        Sp(:,:,cruc,linea)    = spice(0,TP(:,:,cruc,linea),SA(:,:,cruc,linea));                                 % 'Spiciness'
        s0(:,:,cruc,linea)    = gsw_sigma0_CT(SA(:,:,cruc,linea),TC(:,:,cruc,linea));                           % Densidad 'sigma 0'
        
%         [YY,MM,DD,HH,MN,SS] = datevec(fecha(:,:,cruc,linea)); mes = nanmean(MM);
%         if mes == 12 || mes <= 2        % invierno
%             if linea <= 5; inv = inv; end
%             inv_fecha(:,:,inv,linea) = fecha(:,:,cruc,linea); inv_SA(:,:,inv,linea) = SA(:,:,cruc,linea); inv_TC(:,:,inv,linea) = TC(:,:,cruc,linea);
%             inv_O2(:,:,inv,linea) = O2(:,:,cruc,linea); inv_DP(:,:,inv,linea) = DP(:,:,cruc,linea); inv_Sp(:,:,inv,linea) = Sp(:,:,cruc,linea);
%             inv_TP(:,:,inv,linea) = TP(:,:,cruc,linea); inv_s0(:,:,inv,linea) = s0(:,:,cruc,linea);
%             inv_xi(:,:,inv,linea) = xi(:,:,cruc,linea); inv_lon(:,:,inv,linea) = lon(:,:,cruc,linea); inv_lat(:,:,inv,linea) = lat(:,:,cruc,linea);
%             if linea == 5; inv = inv + 1; end
%         elseif mes >= 3 && mes <= 5     % primavera
%             if linea <= 5; prim = prim; end
%             prim_fecha(:,:,prim,linea) = fecha(:,:,cruc,linea); prim_SA(:,:,prim,linea) = SA(:,:,cruc,linea); prim_TC(:,:,prim,linea) = TC(:,:,cruc,linea);
%             prim_O2(:,:,prim,linea) = O2(:,:,cruc,linea); prim_DP(:,:,prim,linea) = DP(:,:,cruc,linea); prim_Sp(:,:,prim,linea) = Sp(:,:,cruc,linea);
%             prim_TP(:,:,prim,linea) = TP(:,:,cruc,linea); prim_s0(:,:,prim,linea) = s0(:,:,cruc,linea);
%             prim_xi(:,:,prim,linea) = xi(:,:,cruc,linea); prim_lon(:,:,prim,linea) = lon(:,:,cruc,linea); prim_lat(:,:,prim,linea) = lat(:,:,cruc,linea);
%             if linea == 5; prim = prim + 1; end            
%         elseif mes >= 6 && mes <= 8     % verano
%             if linea <= 5; ver = ver; end
%             ver_fecha(:,:,ver,linea) = fecha(:,:,cruc,linea); ver_SA(:,:,ver,linea) = SA(:,:,cruc,linea); ver_TC(:,:,ver,linea) = TC(:,:,cruc,linea);
%             ver_O2(:,:,ver,linea) = O2(:,:,cruc,linea); ver_DP(:,:,ver,linea) = DP(:,:,cruc,linea); ver_Sp(:,:,ver,linea) = Sp(:,:,cruc,linea);
%             ver_TP(:,:,ver,linea) = TP(:,:,cruc,linea); ver_s0(:,:,ver,linea) = s0(:,:,cruc,linea);
%             ver_xi(:,:,ver,linea) = xi(:,:,cruc,linea); ver_lon(:,:,ver,linea) = lon(:,:,cruc,linea); ver_lat(:,:,ver,linea) = lat(:,:,cruc,linea);
%             if linea == 5; ver = ver + 1; end            
%         elseif mes >= 9 && mes <= 11    % otono
%             if linea <= 5; oto = oto; end
%             oto_fecha(:,:,oto,linea) = fecha(:,:,cruc,linea); oto_SA(:,:,oto,linea) = SA(:,:,cruc,linea); oto_TC(:,:,oto,linea) = TC(:,:,cruc,linea);
%             oto_O2(:,:,oto,linea) = O2(:,:,cruc,linea); oto_DP(:,:,oto,linea) = DP(:,:,cruc,linea); oto_Sp(:,:,oto,linea) = Sp(:,:,cruc,linea);
%             oto_TP(:,:,oto,linea) = TP(:,:,cruc,linea); oto_s0(:,:,oto,linea) = s0(:,:,cruc,linea);
%             oto_xi(:,:,oto,linea) = xi(:,:,cruc,linea); oto_lon(:,:,oto,linea) = lon(:,:,cruc,linea); oto_lat(:,:,oto,linea) = lat(:,:,cruc,linea);
%             if linea == 5; oto = oto + 1; end            
%         end

    end
end


%% PROMEDIOS(DESVIACION ESTANDAR) Y ANOMALIAS GENERALES
for linea = 1:n
    SA_prom(:,:,linea) = nanmean(SA(:,:,:,linea),3); SA_std(:,:,linea) = nanstd(SA(:,:,:,linea),0,3);
    TC_prom(:,:,linea) = nanmean(TC(:,:,:,linea),3); TC_std(:,:,linea) = nanstd(TC(:,:,:,linea),0,3);
    O2_prom(:,:,linea) = nanmean(O2(:,:,:,linea),3); O2_std(:,:,linea) = nanstd(O2(:,:,:,linea),0,3);
    DP_prom(:,:,linea) = nanmean(DP(:,:,:,linea),3); DP_std(:,:,linea) = nanstd(DP(:,:,:,linea),0,3);
    Sp_prom(:,:,linea) = nanmean(Sp(:,:,:,linea),3); Sp_std(:,:,linea) = nanstd(Sp(:,:,:,linea),0,3);
    TP_prom(:,:,linea) = nanmean(TP(:,:,:,linea),3); TP_std(:,:,linea) = nanstd(TP(:,:,:,linea),0,3);
    s0_prom(:,:,linea) = nanmean(s0(:,:,:,linea),3); s0_std(:,:,linea) = nanstd(s0(:,:,:,linea),0,3);
    xi_prom(:,:,linea) = nanmean(xi(:,:,:,linea),3); 
    lon_prom(:,:,linea) = nanmean(lon(:,:,:,linea),3);
    lat_prom(:,:,linea) = nanmean(lat(:,:,:,linea),3);
    
    for cruc = 1:m
        SA_anm(:,:,cruc,linea) = SA(:,:,cruc,linea) - SA_prom(:,:,linea); TC_anm(:,:,cruc,linea) = TC(:,:,cruc,linea) - TC_prom(:,:,linea);
        O2_anm(:,:,cruc,linea) = O2(:,:,cruc,linea) - O2_prom(:,:,linea); DP_anm(:,:,cruc,linea) = DP(:,:,cruc,linea) - DP_prom(:,:,linea);
        Sp_anm(:,:,cruc,linea) = Sp(:,:,cruc,linea) - Sp_prom(:,:,linea); TP_anm(:,:,cruc,linea) = TP(:,:,cruc,linea) - TP_prom(:,:,linea);
        s0_anm(:,:,cruc,linea) = s0(:,:,cruc,linea) - s0_prom(:,:,linea);
    end
    
end
    
%% PROMEDIOS(DESVIACION ESTANDAR) Y ANOMALIAS ESTACIONALES 
for linea = 1:n
%%%%%%%%%%%%%%%%% INVIERNO %%%%%%%%%%%%%%%    
%     SA_est_inv(:,:,linea) = nanmean(inv_SA(:,:,:,linea),3); SA_std_inv(:,:,linea) = nanstd(inv_SA(:,:,:,linea),0,3);
%     TC_est_inv(:,:,linea) = nanmean(inv_TC(:,:,:,linea),3); TC_std_inv(:,:,linea) = nanstd(inv_TC(:,:,:,linea),0,3);
%     O2_est_inv(:,:,linea) = nanmean(inv_O2(:,:,:,linea),3); O2_std_inv(:,:,linea) = nanstd(inv_O2(:,:,:,linea),0,3);
%     DP_est_inv(:,:,linea) = nanmean(inv_DP(:,:,:,linea),3); DP_std_inv(:,:,linea) = nanstd(inv_DP(:,:,:,linea),0,3);
%     Sp_est_inv(:,:,linea) = nanmean(inv_Sp(:,:,:,linea),3); Sp_std_inv(:,:,linea) = nanstd(inv_Sp(:,:,:,linea),0,3);
%     TP_est_inv(:,:,linea) = nanmean(inv_TP(:,:,:,linea),3); TP_std_inv(:,:,linea) = nanstd(inv_TP(:,:,:,linea),0,3);
%     s0_est_inv(:,:,linea) = nanmean(inv_s0(:,:,:,linea),3); s0_std_inv(:,:,linea) = nanstd(inv_s0(:,:,:,linea),0,3);
%     fecha_est_inv(:,:,linea) = nanmean(inv_fecha(:,:,:,linea),3);
%     xi_est_inv(:,:,linea) = nanmean(inv_xi(:,:,:,linea),3); 
%     lon_est_inv(:,:,linea) = nanmean(inv_lon(:,:,:,linea),3);
%     lat_est_inv(:,:,linea) = nanmean(inv_lat(:,:,:,linea),3);
    
%%%%%%%%%%%%%%% PRIMAVERA %%%%%%%%%%%%%%%%%%    
    SA_est_prim(:,:,linea) = nanmean(prim_SA(:,:,:,linea),3); SA_std_prim(:,:,linea) = nanstd(prim_SA(:,:,:,linea),0,3);
    TC_est_prim(:,:,linea) = nanmean(prim_TC(:,:,:,linea),3); TC_std_prim(:,:,linea) = nanstd(prim_TC(:,:,:,linea),0,3);
    O2_est_prim(:,:,linea) = nanmean(prim_O2(:,:,:,linea),3); O2_std_prim(:,:,linea) = nanstd(prim_O2(:,:,:,linea),0,3);
    DP_est_prim(:,:,linea) = nanmean(prim_DP(:,:,:,linea),3); DP_std_prim(:,:,linea) = nanstd(prim_DP(:,:,:,linea),0,3);
    Sp_est_prim(:,:,linea) = nanmean(prim_Sp(:,:,:,linea),3); Sp_std_prim(:,:,linea) = nanstd(prim_Sp(:,:,:,linea),0,3);
    TP_est_prim(:,:,linea) = nanmean(prim_TP(:,:,:,linea),3); TP_std_prim(:,:,linea) = nanstd(prim_TP(:,:,:,linea),0,3);
    s0_est_prim(:,:,linea) = nanmean(prim_s0(:,:,:,linea),3); s0_std_prim(:,:,linea) = nanstd(prim_s0(:,:,:,linea),0,3);
    fecha_est_prim(:,:,linea) = nanmean(prim_fecha(:,:,:,linea),3);
    xi_est_prim(:,:,linea) = nanmean(prim_xi(:,:,:,linea),3); 
    lon_est_prim(:,:,linea) = nanmean(prim_lon(:,:,:,linea),3);
    lat_est_prim(:,:,linea) = nanmean(prim_lat(:,:,:,linea),3);
    
%%%%%%%%%%%%%% VERANO %%%%%%%%%%%%%%%%%
    SA_est_ver(:,:,linea) = nanmean(ver_SA(:,:,:,linea),3); SA_std_ver(:,:,linea) = nanstd(ver_SA(:,:,:,linea),0,3);
    TC_est_ver(:,:,linea) = nanmean(ver_TC(:,:,:,linea),3); TC_std_ver(:,:,linea) = nanstd(ver_TC(:,:,:,linea),0,3);
    O2_est_ver(:,:,linea) = nanmean(ver_O2(:,:,:,linea),3); O2_std_ver(:,:,linea) = nanstd(ver_O2(:,:,:,linea),0,3);
    DP_est_ver(:,:,linea) = nanmean(ver_DP(:,:,:,linea),3); DP_std_ver(:,:,linea) = nanstd(ver_DP(:,:,:,linea),0,3);
    Sp_est_ver(:,:,linea) = nanmean(ver_Sp(:,:,:,linea),3); Sp_std_ver(:,:,linea) = nanstd(ver_Sp(:,:,:,linea),0,3);
    TP_est_ver(:,:,linea) = nanmean(ver_TP(:,:,:,linea),3); TP_std_ver(:,:,linea) = nanstd(ver_TP(:,:,:,linea),0,3);
    s0_est_ver(:,:,linea) = nanmean(ver_s0(:,:,:,linea),3); s0_std_ver(:,:,linea) = nanstd(ver_s0(:,:,:,linea),0,3);
    fecha_est_ver(:,:,linea) = nanmean(ver_fecha(:,:,:,linea),3);
    xi_est_ver(:,:,linea) = nanmean(ver_xi(:,:,:,linea),3); 
    lon_est_ver(:,:,linea) = nanmean(ver_lon(:,:,:,linea),3);
    lat_est_ver(:,:,linea) = nanmean(ver_lat(:,:,:,linea),3);

%%%%%%%%%%%%%% OTONO %%%%%%%%%%%%%%%%%    
    SA_est_oto(:,:,linea) = nanmean(oto_SA(:,:,:,linea),3); SA_std_oto(:,:,linea) = nanstd(oto_SA(:,:,:,linea),0,3);
    TC_est_oto(:,:,linea) = nanmean(oto_TC(:,:,:,linea),3); TC_std_oto(:,:,linea) = nanstd(oto_TC(:,:,:,linea),0,3);
    O2_est_oto(:,:,linea) = nanmean(oto_O2(:,:,:,linea),3); O2_std_oto(:,:,linea) = nanstd(oto_O2(:,:,:,linea),0,3);
    DP_est_oto(:,:,linea) = nanmean(oto_DP(:,:,:,linea),3); DP_std_oto(:,:,linea) = nanstd(oto_DP(:,:,:,linea),0,3);
    Sp_est_oto(:,:,linea) = nanmean(oto_Sp(:,:,:,linea),3); Sp_std_oto(:,:,linea) = nanstd(oto_Sp(:,:,:,linea),0,3);
    TP_est_oto(:,:,linea) = nanmean(oto_TP(:,:,:,linea),3); TP_std_oto(:,:,linea) = nanstd(oto_TP(:,:,:,linea),0,3);
    s0_est_oto(:,:,linea) = nanmean(oto_s0(:,:,:,linea),3); s0_std_oto(:,:,linea) = nanstd(oto_s0(:,:,:,linea),0,3);
    fecha_est_oto(:,:,linea) = nanmean(oto_fecha(:,:,:,linea),3);
    xi_est_oto(:,:,linea) = nanmean(oto_xi(:,:,:,linea),3); 
    lon_est_oto(:,:,linea) = nanmean(oto_lon(:,:,:,linea),3);
    lat_est_oto(:,:,linea) = nanmean(oto_lat(:,:,:,linea),3);

    for cruc = 1:2
%         SA_anm_inv(:,:,cruc,linea) = inv_SA(:,:,cruc,linea) - SA_est_inv(:,:,linea); TC_anm_inv(:,:,cruc,linea) = inv_TC(:,:,cruc,linea) - TC_est_inv(:,:,linea);
%         O2_anm_inv(:,:,cruc,linea) = inv_O2(:,:,cruc,linea) - O2_est_inv(:,:,linea); DP_anm_inv(:,:,cruc,linea)  = inv_DP(:,:,cruc,linea)  - DP_est_inv(:,:,linea);
%         Sp_anm_inv(:,:,cruc,linea) = inv_Sp(:,:,cruc,linea) - Sp_est_inv(:,:,linea); TP_anm_inv(:,:,cruc,linea) = inv_TP(:,:,cruc,linea) - TP_est_inv(:,:,linea);
%         s0_anm_inv(:,:,cruc,linea) = inv_s0(:,:,cruc,linea) - s0_est_inv(:,:,linea);
        
        SA_anm_prim(:,:,cruc,linea) = prim_SA(:,:,cruc,linea) - SA_est_prim(:,:,linea); TC_anm_prim(:,:,cruc,linea) = prim_TC(:,:,cruc,linea) - TC_est_prim(:,:,linea);
        O2_anm_prim(:,:,cruc,linea) = prim_O2(:,:,cruc,linea) - O2_est_prim(:,:,linea); DP_anm_prim(:,:,cruc,linea)  = prim_DP(:,:,cruc,linea)  - DP_est_prim(:,:,linea);
        Sp_anm_prim(:,:,cruc,linea) = prim_Sp(:,:,cruc,linea) - Sp_est_prim(:,:,linea); TP_anm_prim(:,:,cruc,linea) = prim_TP(:,:,cruc,linea) - TP_est_prim(:,:,linea);
        s0_anm_prim(:,:,cruc,linea) = prim_s0(:,:,cruc,linea) - s0_est_prim(:,:,linea);
        
        SA_anm_ver(:,:,cruc,linea) = ver_SA(:,:,cruc,linea) - SA_est_ver(:,:,linea); TC_anm_ver(:,:,cruc,linea) = ver_TC(:,:,cruc,linea) - TC_est_ver(:,:,linea);
        O2_anm_ver(:,:,cruc,linea) = ver_O2(:,:,cruc,linea) - O2_est_ver(:,:,linea); DP_anm_ver(:,:,cruc,linea)  = ver_DP(:,:,cruc,linea)  - DP_est_ver(:,:,linea);
        Sp_anm_ver(:,:,cruc,linea) = ver_Sp(:,:,cruc,linea) - Sp_est_ver(:,:,linea); TP_anm_ver(:,:,cruc,linea) = ver_TP(:,:,cruc,linea) - TP_est_ver(:,:,linea);
        s0_anm_ver(:,:,cruc,linea) = ver_s0(:,:,cruc,linea) - s0_est_ver(:,:,linea);
        
        SA_anm_oto(:,:,cruc,linea) = oto_SA(:,:,cruc,linea) - SA_est_oto(:,:,linea); TC_anm_oto(:,:,cruc,linea) = oto_TC(:,:,cruc,linea) - TC_est_oto(:,:,linea);
        O2_anm_oto(:,:,cruc,linea) = oto_O2(:,:,cruc,linea) - O2_est_oto(:,:,linea); DP_anm_oto(:,:,cruc,linea)  = oto_DP(:,:,cruc,linea)  - DP_est_oto(:,:,linea);
        Sp_anm_oto(:,:,cruc,linea) = oto_Sp(:,:,cruc,linea) - Sp_est_oto(:,:,linea); TP_anm_oto(:,:,cruc,linea) = oto_TP(:,:,cruc,linea) - TP_est_oto(:,:,linea);
        s0_anm_oto(:,:,cruc,linea) = oto_s0(:,:,cruc,linea) - s0_est_oto(:,:,linea);
    end
    
end



%% Graficas

  cmin = minmax_SA(1); cmax = minmax_SA(2);
  SA_min = cmin - 0.1*(cmax - cmin);
  SA_max = cmax + 0.1*(cmax - cmin); 
  SA_axis = [SA_min:(SA_max-SA_min)/200:SA_max];

for i = 1:length(xi); nonan = find(~isnan(SAp(:,i,linea)));
if~isempty(nonan);break;end
end

  figure; pcolor(xi(i:end),Pi,SAp(:,i:end)); shading interp; caxis([SA_min SA_max]);
  colorbarf([SA_min:(SA_max-SA_min)/12:SA_max],[SA_min:(SA_max-SA_min)/12:SA_max]);
  set(gca,'YDir','reverse');
  cX = caxis; hold on
  [C,h] = contour(xi(i:end),Pi,s0p(:,i:end),'k','LineWidth',1); clabel(C,h);
  caxis(cX)

MAP=colormap(jet(10));
caxis([cmin cmax])
colorbarf([0:.2:2],[0:.4:2])
 

hl1 = line(xi,Pi,'Color','k');
ax1 = gca;
set(ax1,'XColor','k','YColor','k')
ax2 = axes('Position',get(ax1,'Position'),'XAxisLocation','top',...
    'YAxisLocation','right','Color','none','XColor','k','YColor','k');
hl2 = line(x,Pi,'Color','k','Parent',ax2);
lance
