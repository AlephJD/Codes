 % A DATOSBTS2 LE FALTA ESTACIONES LON Y LAT, NO SON DEL MISMO TAMANYO QUE
 % S T ETC
% direc=[dir_raiz '/proyectos/Todos_Santos/datos/CTD/finales/'];
clear
files= dir('C:\Users\Aleph\CICESE Job\Datos\datosBTS*mat');
sig=[26.5 25.5]; ps=[10 50 200 400];
x=[-117.3:.025:-116.6]; y=[31.3:.025:32.2];
param=[ .3 .3 .05 .05 .1 .1];
% dir_raiz;
% addpath([dir_raiz '/Powlan/matlab/analisis_objetivo_pepe'])
[X,Y]=meshgrid(x,y);

for fil=1:length(files)
  arch=  [files(fil).name]; %[direc files(fil).name];
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

