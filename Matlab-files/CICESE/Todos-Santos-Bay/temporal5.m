% Para poder realizar comparativo rapido entre variables calculadas por las
% ecuaciones de estado EOS-80 y TEOS-10.

clear
load datosBTS06
 
lon = lon(47); lat = lat(47);
  S = S(:,47);   T = T(:,47);
 
pt0_sw = sw_ptmp(S,T,P,0);                              % temperatura potencial p_ref=0 (SW)
st_sw = sw_dens0(S,T)-1000;                             % sigma-t (SW)
       
SA = gsw_SA_from_SP(S,P,lon,lat);                       % salinidad absoluta (TEOS)
pt0_teos = gsw_pt0_from_t(SA,T,0);                      % temperatura potencial p_ref=0 (TEOS)
stheta_teos = gsw_sigma0_pt0_exact(SA,pt0_teos);        % sigma-theta p-ref=0 (TEOS)
 
st_t_teos = gsw_rho_t_exact(SA,T,0)-1000;               % sigma-t(T) (TEOS)
TC = gsw_CT_from_t(SA,T,P);                             % temperatura conservativa (TEOS)
st_CT_teos = gsw_rho_CT_exact(SA,TC,0)-1000;            % sigma-t(TC) (TEOS)
  
dpot_sw = sw_pden(S,T,P,0)-1000;                        % sigma-theta p_ref=0 (SW)      
dpot_teos = stheta_teos;
  
  
  
plot(S,pt0_sw,'*-b',SA,TC,'.-r')
axis square
legend('S/TP','SA/TC')
hold on
p_ref = 0;
isopics = [22.5:.5:27.5];
isospics = [-2.0:.5:6];
gsw_SA_CT_plot3(SA,TC,pt0,P,p_ref,isopics,isospics,'Crucero BTS6, Lance 47')
 
gsw_SA_CT_plot3(SA,TC,pt0_sw,P,p_ref,isopics,'Crucero BTS6, Lance 47')
 
SA_maxx=34.8690; CT_maxx=19.4576;
SA_minn=33.1918; CT_minn=1.5382;
axis([SA_minn SA_maxx CT_minn CT_maxx]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lineas de codigo que permiten obtener las coordenadas geograficas de las
% estaciones al momento en que el CTD se encuentra en el fondo durante el
% lance. Sirve en la generacion de la tabla de los reportes.
clear
cruc = 11; %[2:4 6 8:10]

files = dir(['C:\Users\Aleaph\CICESE Job\Datos\Datos Cruceros Preprocesados\bts',num2str(cruc),'\CTD\ASC\lan*']);
% files = dir(['C:\Users\Aleph\CICESE Job\Datos\Datos Cruceros Preprocesados\bts',num2str(cruc),'\lan*']);

for n = 1:length(files)
    dat = load(['bts',num2str(cruc),'\CTD\ASC\' files(n).name]);
    dbar(n) = max(dat(:,2)); ind = find(dbar(n)==dat(:,2));
    lat(n) = dat(ind,10); lon(n) = abs(dat(ind,11));
    fecha(n) = dat(ind,9);
end

dbar = dbar'; fecha = fecha';
lat = lat'; lon = lon';
minlat = lat - 31; ind = find(minlat >= 1);
if ~isempty(ind), minlat(ind) = minlat(ind) - 1; end
minlon = lon - 116; ind = find(minlon >= 1);
if ~isempty(ind), minlon(ind) = minlon(ind) - 1; end

lat = lat - minlat; lon = lon - minlon;
minlat = minlat*60;
minlon = minlon*60;
