% Codigo que permite abrir la base de datos (Proyecto Xcambo4) y
% procesarla. Ubica en los archivos los puntos de las estaciones de
% muestreo (lugar donde se realizaron lances CTD ), y las diferencia
% de las mediciones continuas realizados durante la trayectoria del crucero.
% (Open and process the Project Xcambo4 database. Locates the sampling station 
% points in the files (where CTD casts were made), and differentiated them
% of continuous measurements made during the trajectory of the cruise.)

% Elaborado por: Aleph Jimenez.
% Para: Laboratorio de Procesos Costeros y Oceanografia Fisica (LAPCOF)
%       del Centro de Investigacion y de Estudios Avanzados
%       (CINVESTAV) del Instituto Politecnico Nacional (IPN),
%       Unidad Merida.
% Fecha de elaboracion: 2010.05.14
% Ultima fecha de modificacion: 2010.08.24

% Apoyo y colaboracion para la realizacion de este trabajo:
%       www.gabrielortiz.com - Conversion de datos de Coordenadas Geograficas a UTM

%% Carga base de datos de la velocidad de ADCP y de Navegacion del Buque. 
%% (Load ADCP velocity database and ship navegation).

% ADCP
ens=load('ens.dat');                                            % carga el numero de ensamble
t=load('t.dat');                                                % carga el tiempo del ensamble
ua=load('u.dat');                                               % carga la componente 'u' de la velocidad de ADCP
va=load('v.dat');                                               % carga la componente 'v' de la velocidad de ADCP
wa=load('w.dat');                                               % carga la componente 'w' de la velocidad de ADCP
error=load('err.dat');                                          % carga el error de la velocidad de ADCP
maga=load('mag.dat');                                           % carga la magnitud de la velocidad de ADCP
dira=load('dir.dat');                                           % carga la direccion de la velocidad de ADCP

% Ship navigation
navegacion=load('navegacion.dat');                              % carga los datos de navegacion del barco (u,v,mag,dir,flat,flon,llat,llon)
ub=navegacion(:,1);
vb=navegacion(:,2);
magb=navegacion(:,3);
dirb=navegacion(:,4);
flat=navegacion(:,5);
flon=navegacion(:,6);
llat=navegacion(:,7);
llon=navegacion(:,8);

% estaciones=load('estaciones.dat');                              % carga el tiempo inicial y final aproximados cuando el buque esta cerca de la estacion
                                                                  % el orden de las columnas es (ens(i),t(i),flat(i),flon(i),llat(i),llon(i),ens(f),t(f),flat(f),flon(f),llat(f),llon(f))
                                                                  % i:inicial, f:final

%% Carga base de datos de linea de costa del Golfo de Mexico y puntos de las estaciones de muestreo.
%% (Load coastline database and sampling stations points of Gulf of Mexico)

cl=load('GMCL Xcambo4.dat'); xl=cl(:,1);yl=cl(:,2);               % carga parte de la linea de costa del Golfo de Mexico

ep=load('estacionespropuestas.txt');                              % carga coordenadas de las estaciones de muestreo propuestas en el Plan de Crucero
glat=ep(:,1);mlat=ep(:,2);slat=ep(:,3);                         
glon=ep(:,4);mlon=ep(:,5);slon=ep(:,6);

cg=load('Xcambo4 2010 Fechas y Coordenadas ADCP.txt');            % carga coordenadas de las estaciones de muestreo de la Bitacora
glon1=cg(:,1);mlon1=cg(:,2);slon1=cg(:,3);                        % (coordenadas y tiempo)   
glat1=cg(:,4);mlat1=cg(:,5);slat1=cg(:,6);

yy=cg(:,7);mm=cg(:,8);dd=cg(:,9);hh=cg(:,10);mn=cg(:,11);
ss=zeros(size(mn));
tcruc=datenum(yy,mm,dd,hh,mn,ss);                                 % convierte el tiempo (estaciones de bitacora) en formato (y,m,d,h,mn,s) numero serial (e.g. 7.3188e+005)

cpctd=load('Coordenadas Perfiles CTD.txt');                       % carga coordenadas de los puntos donde se realizaron lances de CTD
glat2=cpctd(:,1);mlat2=cpctd(:,2);slat2=cpctd(:,3);
glon2=cpctd(:,4);mlon2=cpctd(:,5);slon2=cpctd(:,6);

                                                                
% Conversion de Coordenadas Geograficas Lat/Lon (sexagesimales = \'b0,',") a
% Grados Decimales.
% (Conversion of geographic coordinates to decimal degrees.)
                                                                
% 1\'b0 = 60'; 1\'b0 = 3600"
% 1' = 60"; 

mlon=mlon/60; slon=slon/3600;
glond=glon*(-1)+(mlon+slon);glond=glond*(-1);

mlat=mlat/60;slat=slat/3600;
glatd=glat+(mlat+slat);

% %%%%
mlon1=mlon1/60; slon1=slon1/3600;                                 % transforma las coordenadas geograficas (lon,lat) en formato (\'ba,',")
glond1=glon1+(mlon1+slon1);glond1=glond1*(-1);                    % a grados decimales

mlat1=mlat1/60;slat1=slat1/3600;
glatd1=glat1+(mlat1+slat1);

% %%%%
mlon2=mlon2/60; slon2=slon2/3600;
glond2=glon2*(-1)+(mlon2+slon2);glond2=glond2*(-1);

mlat2=mlat2/60;slat2=slat2/3600;
glatd2=glat2+(mlat2+slat2);

plot(xl,yl),hold on
plot(glond,glatd,'cs')
plot(glond1,glatd1,'.-r')
plot(glond2,glatd2,'*k')

    % Proceso inverso de transformacion. Coordenadas Geograficas en Grados
    % Decimales a Geograficas Lat/Lon (Sexagesimal).
    % (Reverse transformation process. Geographic coordinates in decimal to 
    % geographical ones.)

glatd=M(:,133);         glond=M(:,134)*(-1);    %74.9055.. (e.g.)
glat=fix(glatd);        glon=fix(glond);        %74
rlatg=glatd-glat;       rlong=glond-glon;       %0.90555..
mlatd=rlatg*60;         mlond=rlong*60;         %54.3333..
mlat=fix(mlatd);        mlon=fix(mlond);        %54
rlatm=mlatd-mlat;       rlonm=mlond-mlon;       %0.3333..
slatd=fix(rlatm*60);    slond=fix(rlonm*60);    %20      

    % Corrige los valores de velocidad de ADCP respecto a los de Navegacion
    % para obtener la velocidad real de la Corriente.
    % (Corrects the ADCP speed values with respect to the navigation values
    % to obtain the actual speed of the current.)
    % Vadcp = Vbuque + Vcorriente -----> Vcorriente = Vadcp + Vcorriente

    fid1=fopen('uc_nvcg.dat','a');
    fid2=fopen('vc_nvcg.dat','a');
    
    si=size(u_a); si=si(1);
    clock
    for j=1:si-1
        uc = unavcg(j) + u_a(j,:) ;
        vc = vnavcg(j) + v_a(j,:);
        fprintf(fid1,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\\n',uc);
        fprintf(fid2,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\\n',vc);
    end
    clock    
    fclose(fid1);
    fclose(fid2);
    uc=uc/10; vc=vc/10;                                                             % convierte unidades a cm*s-1

    quiver(flon(1:1200:end),flat(1:1200:end),uc_s(1:1200:end),vc_s(1:1200:end))
    
    % Obtiene el punto inicial y final cercano a la estacion marcado en la
    % Bitacora.
    % (Gets the initial and final points near the station marked on the
    % ship's logbook).

      si=length(glatd1); % i=0;
      s=17/3600;    % ~500m
      for k=1:si
          lat=glatd1(k);lon=glond1(k);
          lat=[lat+s,lat-s];
          lon=[lon+s,lon-s];
          i=find(flat<=lat(1) & flat>=lat(2) & flon<=lon(1) & flon>=lon(2));
%           t_est(:,k)=t(i);
          figure(3)
          hold on; quiver(flon(i),flat(i),uc_s(i),vc_s(i));
      end
      
           flatm=nanmean(flat(i));
           flonm=nanmean(flon(i));
           uc_sm=nanmean(uc_s(i));
           vc_sm=nanmean(vc_s(i));
           figure(4)
           hold on; quiver(flonm,flatm,uc_sm,vc_sm,0.001);
          
           u_est(  ,:,k)=uc(i,:);
           v_est(  ,:,k)=vc(i,:);
           flat_est(:,k)=flat(i); flon_est(:,k)=flon(i);
           lat=[];lon=[];

%           % Calcula promedios de las componentes para la estacion 
%           % y obtiene una coordenada geografica promedio del transecto

               uestm=nanmean(uest,2); vestm=nanmean(vest,2);
               uestm=nanmean(uestm); vestm=nanmean(vestm);
               flatm(k)=nanmean(flat_est(:,k)); flonm(k)=nanmean(flon_est(:,k));
%       end

           j=length(inicio:fin); j=j+i;
           i=i+1;
           estacion=[i,j,test,uest,vest,flat_est,flon_est];
           i=j;

      
      lat=[lat+s,lat+s,lat-s,lat-s];
      lon=[lon-s,lon+s,lon+s,lon-s];


     uc=nanmean(uc,2); vc=nanmean(vc,2);                                             % calcula el promedio sobre el espacio renglon (en la columna de agua)
     [dirp magp]=cart2pol(uc,vc);                                                    % obtiene la magnitud y direccion del vector resultante del promedio de la columna de agua y del transecto
     max(magp)
     uc=nanmean(uc); vc=nanmean(vc);                                                 % calcula el promedio sobre el espacio columna (en el tiempo)    
     [dirp magp]=cart2pol(uc,vc);                                                    % obtiene la magnitud y direccion del vector resultante del promedio de la columna de agua y del transecto
     dirp=dirp*180/pi;                                                               % transforma de radianes a grados.

     for i=1:length(dirp)
         if dirp(i)>=0 & dirp(i)<=90         % 0\'b0-90\'b0
             dirp(i)=90-dirp(i);
         elseif dirp(i)<0 & dirp(i)>=-180    % 91\'b0-270\'b0
             dirp(i)=90-dirp(i);
         elseif dirp(i)>90 & dirp(i)<=180    % 271\'b0-360\'b0
             dirp(i)=450-dirp(i);
         end
     end
     magp

    [x,y,utmzone]=deg2utm(flat,flon);
    x=diff(x); y=diff(y);
    i=size(u_a); i=i(1); j=2:i; i=1:i-1;
    dt=round(etime([Y(j),M(j),D(j),H(j),MN(j),round(S(j))],[Y(i),M(i),D(i),H(i),MN(i),round(S(i))]));
    ds=sqrt(x.^2+y.^2);
    vel=ds./dt;


% GRAFICAS
% (GRAPHICS)
     figure(1)
     hold on; plot(flon,flat,'g')
     figure(1)
     hold on; quiver(flonm,flatm,uc,vc,0.001);


si=size(uc_s); si=si(1); si=floor(si/100);
n=1;i=100;
for j=1:si
    uc_s1(j)=nanmean(uc_s(n:i));
    vc_s1(j)=nanmean(vc_s(n:i));
    flat1(j)=nanmean(flat(n:i));
    flon1(j)=nanmean(flon(n:i));
    n=i+1;
    i=i+100;
end
 