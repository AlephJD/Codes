% Codigo que lee los archivos de subida o bajada de CTD de los cruceros y
% permite verificar si existe algun lance "malo".
% (Read 'up'/'down' CTD files from cruises. Allow to verify if is there a 
% 'bad' cast.)

% Realizado por: Aleph Jimenez
% Para: CICESE

clear
%close all
cruc = 15; %[2:4 6 8:10]

%  files = dir(['C:\Users\Aleaph\CICESE Job\Datos\Calibracion\CBTS',num2str(cruc),'\lan*']);
 files = dir(['C:\Users\Aleaph\CICESE Job\Datos\Base Datos Preprocesados\bts',num2str(cruc),'\lan*']);
% files = dir(['C:\Users\Aleaph\My Documents\MATLAB\BTS',num2str(cruc),'\Sub\Prim\ln*']);
hdr = load(['poctdBTS',num2str(cruc)]);
Pmax = hdr(:,6); P = [1:max(Pmax)]';

for n = 1:length(files)
%      dat = load(['C:\Users\Aleaph\CICESE Job\Datos\Calibracion\CBTS',num2str(cruc),'\' files(n).name]);
     dat = load(['C:\Users\Aleaph\CICESE Job\Datos\Base Datos Preprocesados\bts',num2str(cruc),'\' files(n).name]);
%    dat = load(['C:\Users\Aleaph\My Documents\MATLAB\BTS',num2str(cruc),'\Sub\Prim\' files(n).name]);
    
    ind = find(dat(:,3) < 99); if ~isempty(ind) && length(ind) >= 2; S(:,n) = interp1(dat(ind,1),dat(ind,3),P);    else    S(:,n) = NaN*ones(length(P),1); end;
    ind = find(dat(:,2) < 99); if ~isempty(ind) && length(ind) >= 2; T(:,n) = interp1(dat(ind,1),dat(ind,2),P);    else    T(:,n) = NaN*ones(length(P),1); end;
    ind = find(dat(:,4) < 99); if ~isempty(ind) && length(ind) >= 2; O2(:,n) = interp1(dat(ind,1),dat(ind,4),P);   else   O2(:,n) = NaN*ones(length(P),1); end;
    ind = find(dat(:,5) < 99); if ~isempty(ind) && length(ind) >= 2; Chla(:,n) = interp1(dat(ind,1),dat(ind,5),P); else Chla(:,n) = NaN*ones(length(P),1); end;

% S(:,n) = dat(:,3);
% T(:,n) = dat(:,2);
% O2(:,n) = dat(:,4);
% Chla(:,n) = dat(:,5);

end

    figure; hold on
    plot(S,T); xlabel('S [ups]'); ylabel('T [ºC]'); title(['BTS',num2str(cruc)]);axis square

    figure; hold on
    plot(S,P); set(gca,'YDir','reverse');
    xlabel('Salinidad [ups]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square
    
    figure; hold on
    plot(T,P); set(gca,'YDir','reverse');
    xlabel('Temperatura [ºC]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square
    
    figure; hold on
    plot(O2,P); set(gca,'YDir','reverse');
    xlabel('Oxígeno Disuelto [ml{\cdot}L^-^1]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square
    
    figure; hold on
    plot(Chla,P); set(gca,'YDir','reverse');
    xlabel('Clorofila "a" [µ{\cdot}L^-^1]'); ylabel('Pressure [dbar]'); title(['BTS',num2str(cruc)]);axis square
