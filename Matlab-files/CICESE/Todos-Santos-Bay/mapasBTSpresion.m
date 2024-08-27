% Carga archivos de datos de 'datosBTS*', y realiza mapas de variables
% hidrograficas mediante mapeo(analisis) objetivo.
% (Makes objective mapping (analysis) graphs of hydrographic variables. Load
% data from 'datosBTS*' files.)

% Realizado por: Aleph Jimenez
% Para: CICESE 
% Fecha: 21.10.2011

clear
files= dir('C:\Users\Aleph\CICESE Job\Datos\datosBTS*mat');
sig=[26.5 25.5]; ps=[10 50 200 400];
x=[-117.3:.025:-116.6]; y=[31.3:.025:32.2];
param=[ .3 .3 .05 .05 .1 .1];
[X,Y]=meshgrid(x,y);

for fil=1:length(files)
  arch=  [files(fil).name];
  load(arch); 
  if fil==2 inds=1:length(lon)-1; else inds=1:length(lon); end
  data=[];
  for den=1:length(ps)
    a=find(P==ps(den));
    spp=SP(a,inds); ss=S(a,inds); tt=T(a,inds); dd=D(a,inds);
    nonan=~isnan(spp)&~isnan(ss)&~isnan(tt);
    data=[spp(nonan(:))' ss(nonan(:))' tt(nonan(:))' dd(nonan(:))'];  
    mapsig=objmaps(data,lon(nonan(:)),lat(nonan(:)),param,x(:),y(:));
    mapSP(:,:,den)=mapsig(:,:,1);
    mapS(:,:,den)=mapsig(:,:,2);
    mapT(:,:,den)=mapsig(:,:,3);
    mapD(:,:,den)=mapsig(:,:,4);
  end  
end

