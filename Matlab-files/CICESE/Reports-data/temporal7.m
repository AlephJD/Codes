% Lineas de codigo que permiten obtener las coordenadas geograficas de las
% estaciones al momento en que el CTD se encuentra en el fondo durante el
% lance. Sirve en la generacion de la tabla de los reportes.

clear
cruc = 15;

files = dir(['C:\Users\Aleaph\CICESE Job\Datos\BTS\BTS',num2str(cruc),'\CTD\ASC\lan*']);
% files = dir(['C:\Users\Aleph\CICESE Job\Datos\Datos Cruceros Preprocesados\bts',num2str(cruc),'\lan*']);

for n = 1:length(files)
    dat = load(['C:\Users\Aleaph\CICESE Job\Datos\BTS\BTS',num2str(cruc),'\CTD\ASC\' files(n).name]);
    lance(n) = n; dbar(n) = max(dat(:,2)); ind = find(dbar(n)==dat(:,2));
    
%     %% Seccion que genera los archivos de posición de los lances (poctdBTS*)
%     lat(n) = dat(ind,9); lon(n) = abs(dat(ind,10));
%     fecha(n) = dat(ind,11);
% end
 
%     lance = lance'; dbar = dbar'; fecha = fecha';
%     lat = lat'; lon = lon';
%     minlat = lat - 31; ind = find(minlat >= 1);
%     if ~isempty(ind), minlat(ind) = minlat(ind) - 1; end
%     minlon = lon - 116; ind = find(minlon >= 1);
%     if ~isempty(ind), minlon(ind) = minlon(ind) - 1; end
  
%     lat = lat - minlat; lon = lon - minlon;
%     minlat = minlat*60;
%     minlon = minlon*60;
  
%     fecha = datestr(fecha);
%     fecha = datevec(fecha);
%     yy = fecha(:,1); mm = fecha(:,2); dd = fecha(:,3);     hh = fecha(:,4); mn = fecha(:,5); ss = fecha(:,6);
   
%     datos = [lance lat minlat lon minlon dbar hh mn ss dd mm yy];
%     
%     fid = fopen(['poctdBTS',num2str(cruc)],'w');
%     for i = 1:length(fecha)
%         fprintf(fid,'%1g%11g%11.4f%11g%11.4f%11g%11g%11g%11g%11g%11g%11g\n',datos(i,:));
%     end
%     fclose(fid);

%% Seccion que genera las carpetas con los archivos de bajada y subida

%Datos para calibracion cruceros BTS11 a BTS14.
% O2 calib = O2ctd*m1+b1; 
% S  calib = Sctd*m2+b2

%crucero m1     b1      m2      b2
% 11	1.0816	0.1880	0.9813	0.6386
% 12    1.0152	0.4125	0.9527	1.6295
% 13	0.9145	0.5329	0.9958	0.1710
% 14	0.9958	0.5232	0.9589	1.4232 

m1 = 1.0816; b1 = 0.1880;
m2 = 0.9813; b2 = 0.6386;

    presionb = dat(1:ind,2); tempb = dat(1:ind,3); salb = dat(1:ind,14);
    oxi2b = dat(1:ind,13); clorofb = dat(1:ind,8);
 
    presions = dat(ind:end,2); temps = dat(ind:end,3); sals = dat(ind:end,14);
    oxi2s = dat(ind:end,13); clorofs = dat(ind:end,8);
     
    datab = [presionb tempb salb oxi2b clorofb];
    datas = [presions temps sals oxi2s clorofs]; datas = flipud(datas);
     
    fid = fopen(files(n).name,'w');
    for i = 1:length(datab)
    fprintf(fid,'%11.1f%11.4f%11.4f%11.5f%11.5f\n',datab(i,:));
    end
    fclose(fid);
    
    fid = fopen(files(n).name,'w');
    for i = 1:length(datas)
    fprintf(fid,'%11.1f%11.4f%11.4f%11.5f%11.5f\n',datas(i,:));
    end
    fclose(fid);
    
end



%     presionb = dat(1:ind,2); tempb = dat(1:ind,4); salb = dat(1:ind,14);
%     oxi2b = dat(1:ind,7); clorofb = dat(1:ind,8);
%     latb = dat(1:ind,9); lonb = abs(dat(1:ind,10)); fechab = dat(1:ind,11);
% 
%     presions = dat(ind:end,2); temps = dat(ind:end,4); sals = dat(ind:end,14);
%     oxi2s = dat(ind:end,7); clorofs = dat(ind:end,8);
%     lats = dat(ind:end,9); lons = abs(dat(ind:end,10)); fechas = dat(ind:end,11);
