% Carga las matrices de interpolacion de variables hidrograficas de las campanias
% BTS's en la region interior de la Bahia de Todos Santos y grafica los resultados
% de esas matrices en diagramas T/S, secciones transversales y campos horizontales.

% Realizado por: Aleph Jimenez
% Para: CICESE
% Fecha 24.11.2011
close all
clear
load bts_int
load minmax
%% Carga archivos de batimetria y linea de costa
% linea de costa
%load baja_golfo; cx=xx; cy=yy;
% batimetria
%load BCN_CA_6s; bx=x; by=y; bz=z;

p_ref = 0;
isopics = [24.0:.5:27.5];
isospics = [-2.0:.5:6];
n = size(bts_int);
m = n(1); n = n(2);

for cruc = 2:m
    clf
    for linea = 1:n
        
        lance = bts_int(cruc,linea).lance;
        x     = bts_int(cruc,linea).x;
        fecha = bts_int(cruc,linea).datei;
        xi    = bts_int(cruc,linea).xi;
        lon   = bts_int(cruc,linea).loni;
        lat   = bts_int(cruc,linea).lati;
        S     = bts_int(cruc,linea).S;
        T     = bts_int(cruc,linea).T;
        O2    = bts_int(cruc,linea).O2;
        D     = bts_int(cruc,linea).D;
        P     = bts_int(cruc,linea).P;
        SA    = gsw_SA_from_SP(S,P,lon,lat);   % Salinidad absoluta
        TC    = gsw_CT_from_t(SA,T,P);         % Temperatura conservativa
        DP    = gsw_pot_rho_t_exact(SA,T,P,0); % Densidad potencial
        TP    = gsw_pt_from_CT(SA,TC);         % Temperatura potencial                
        Sp    = spice(0,TP,SA);                % 'Spiciness'
        s0    = gsw_sigma0_CT(SA,TC);          % Densidad 'sigma 0'
             
        for i = 1:length(xi); nonan = find(~isnan(SA(:,i)));  % meter dentro del ciclo 'vars = 1:4'
            if~isempty(nonan);break;end
        end
        
%         for vars = 1:4
%             switch vars
%                 case 1; var1 = SA; var2 = anmSA; cmin = minmax_SA(1); cmax = minmax_SA(2); cmin_a = minmax_anmSA(1); cmax_a = minmax_anmSA(2);
%                 case 2; var1 = O2; var2 = anmO2; cmin = minmax_O2(1); cmax = minmax_O2(2); cmin_a = minmax_anmO2(1); cmax_a = minmax_anmO2(2);
%                 case 3; var1 = TC; var2 = anmTC; cmin = minmax_TC(1); cmax = minmax_TC(2); cmin_a = minmax_anmTC(1); cmax_a = minmax_anmTC(2);
%                 case 4; var1 = Sp; var2 = anmSp; cmin = minmax_Sp(1); cmax = minmax_Sp(2); cmin_a = minmax_anmSp(1); cmax_a = minmax_anmSp(2);
%             end
%             
%             for k = 1:2
%             if k == 1; figure(linea); subplot(2,2,vars); pcolor(xi(i:end),P,var1(:,i:end)); shading interp; colorbar; caxis([cmin cmax]);
%             elseif k == 2; figure(n + linea); subplot(2,2,vars); pcolor(xi(i:end),P,var2(:,i:end)); shading interp; colorbar; caxis([cmin_a cmax_a]);
%             end
%             set(gca,'YDir','reverse');
%             cX = caxis; hold on
%             [C,h] = contour(xi(i:end),P,s0(:,i:end),'k','LineWidth',1); clabel(C,h);
%             caxis(cX)
%             if vars == 1 && k == 1; title('Salinidad Absoluta (g/Kg)'); ylabel('Presión (dbar)'); 
%                 elseif vars == 1 && k == 2; title('Anomalia de Salinidad Absoluta (g/Kg)'); ylabel('Presión (dbar)');
%             elseif vars == 2 && k == 1; title('Oxígeno Disuelto (ml/L)'); 
%                 elseif vars == 2 && k == 2; title('Anomalia de Oxígeno Disuelto (ml/L)');
%             elseif vars == 3 && k == 1; title('Temperatura Conservativa (ºC)'); ylabel('Presión (dbar)'); xlabel('Distancia (km)'); 
%                 elseif vars == 3 && k == 2; title('Anomalia de Temperatura Conservativa (ºC)'); ylabel('Presión (dbar)'); xlabel('Distancia (km)');
%             elseif vars == 4 && k == 1; title('Spiciness ({\pi})'); xlabel('Distancia (km)'); 
%                 elseif vars == 4 && k == 2; title('Anomalia de Spiciness ({\pi})'); xlabel('Distancia (km)');
%             end % if vars == 1 && k == 1
%             end % for k = 1:2
%         end % for vars = 1:4
        
        % DIAGRAMA T/S
%         SA2(:,:,linea) = SA; TC2(:,:,linea) = TC; TP2(:,:,linea) = TP;
%         figure(n*2 + 1); hold on
%         if linea == 1;plot(SA,TC,'.k');elseif linea == 2;plot(SA,TC,'.r');elseif linea == 3;plot(SA,TC,'.b');
%         elseif linea == 4;plot(SA,TC,'.g');elseif linea == 5;plot(SA,TC,'.m');
%         end
%         if linea == n
%             SA2 = [min(SA2(:)) max(SA2(:))]; TC2 = [min(TC2(:)) max(TC2(:))]; TP2 = [min(TP2(:)) max(TP2(:))];
%             figure(n*2 + 1); hold on
%             gsw_SA_CT_plot2(SA2,TC2,TP2,p_ref,isopics,isospics,'Crucero BTS')
%         end

    end % for linea = 1:n
    clear SA2 TC2 TP2
end % cruc = 1:m


% Absolute Salinity - Conservative Temperature plotting function 
%  gsw_SA_CT_plot              - function to plot Absolute Salinity - Conservative Temperature
%                                profiles on the SA-CT diagram, including the freezing line
%                                and selected potential density contours
%  gsw_SA_CT_plot(SA,CT,p_ref,isopycs,title_string)

% density and enthalpy, based on the 48-term expression for density 
% (The functions in this group ending in "_CT" may also be called without "_CT".)
%  gsw_rho_CT                  - in-situ density from CT, and potential density
%  gsw_sigma0_CT               - sigma0 from CT with reference pressure of 0 dbar


%         pt = gsw_pt_from_CT(SA,CT)            - potential temperature from Conservative Temperature 
%         gsw_pt0_from_t              - potential temperature with a reference pressure of zero dbar
%         gsw_pt_from_t               - potential temperature


% Consultar la funcion 'Axes Properties' para poder revertir la direccion de
% los valores en la grafica.


