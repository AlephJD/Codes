% Lineas de codigo que permiten obtener las coordenadas geograficas de las
% estaciones al momento en que el CTD se encuentra en el fondo durante el
% lance. Sirve en la generacion de la tabla de los reportes.

% Genera los datos de crucero calibrados.

clear
cruc = 14;

%Datos para calibracion cruceros BTS11 a BTS14.
% O2 calib = O2ctd*m1+b1; 
% S  calib = Sctd*m2+b2

%crucero m1     b1      m2      b2
% 11	1.0816	0.1880	0.9813	0.6386
% 12    1.0152	0.4125	0.9527	1.6295
% 13	0.9145	0.5329	0.9958	0.1710
% 14	0.9958	0.5232	0.9589	1.4232 

m1 = 0.9958; b1 = 0.5232;
m2 = 0.9589; b2 = 1.4232;

files = dir(['C:\Users\Aleaph\My Documents\MATLAB\BTS',num2str(cruc),'\Sub\Prim\ln*']);
% files = dir(['C:\Users\Aleph\CICESE Job\Datos\Datos Cruceros Preprocesados\bts',num2str(cruc),'\lan*']);

for n = 1:length(files)
    dat = load(['C:\Users\Aleaph\My Documents\MATLAB\BTS',num2str(cruc),'\Sub\Prim\' files(n).name]);
%     lance(n) = n; dbar(n) = max(dat(:,2)); ind = find(dbar(n)==dat(:,2));

ind = find(dat(:,3) < 99); if ~isempty(ind); dat(ind,3) = dat(ind,3)*m2 + b2; end
ind = find(dat(:,4) < 99); if ~isempty(ind); dat(ind,4) = dat(ind,4)*m1 + b1; end
     
    fid = fopen(files(n).name,'w');
    for i = 1:length(dat)
    fprintf(fid,'%11.1f%11.4f%11.4f%11.5f%11.5f\n',dat(i,1:5));
    end
    fclose(fid);
    
end
