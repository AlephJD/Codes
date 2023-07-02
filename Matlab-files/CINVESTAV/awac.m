% Codigo que procesa archivos en formato ASCII, generando datos estadisticos de
% las variables cada N periodo.
% Los resultados se grafican en una serie de tiempo de N longitud 
% (e.g. 3 meses, 1 día, 12 horas).
% (Process data files in ASCII format. Generates statistical calculations of 
% variables each 'N' period. Results are shown in time series graphics of 'N'
% lenght, e.g.: 3 months, 1 day, 12 hours.)
%
% Elaborado por: Aleph Jimenez.
% Para: Laboratorio de Procesos Costeros y Oceanografia Fisica (LAPCOF) 
%       del Centro de Investigacion y de Estudios Avanzados
%       (CINVESTAV) del Instituto Politecnico Nacional (IPN),
%       Unidad Merida.
% Fecha de elaboracion: 2010.01.07
% Ultima fecha de Modificacion: 2010.06.14

% PENDIENTES:   1)Las brisas seran los fenomenos de más alta frecuencia que se contemplan.

%% Lectura de Archivos (Read files)
%$ Realizar la lectura para el procesamiento de datos a los archivos que se 
%$ pudiesen 'ignorar', en caso de que ocurra una falla en el suministro de energia.
% (Read files for data processing for those files that could be "ignored" if a power
% failure occurs.)

fid=fopen('clock.dat','a+');c=load('clock.dat');
k=c(end,end);k=k+1;c=fix(clock);c=[c k];
fprintf(fid,'%g %g %g %g %g %g %g\n',c);            % graba en el archivo con el identificador 'fid', la fecha actual ('c'). (Saves file with the identifier 'fid', the recent date ('c'))
c=load('clock.dat');c=c(end-1:end,:);k=c(end,end);  % adjudica fecha anterior y la actual, y un contador (k). (Sets the last date and the recent one, and a counter (k)).
fclose(fid)                                             


Y=c(:,1);M=c(:,2);D=c(:,3);H=c(:,4);MN=c(:,5);S=c(:,6);
if (D==1 & H==0)        % cambio de mes
    if(M<=10 | M>1);name=['awac_',num2str(Y(1)),'0',num2str(M(1)),num2str(D(1)),'0001'];end
    if(M>10 | M==1);name=['awac_',num2str(Y(1)),num2str(M(1)),num2str(D(1)),'0001'];end
    name1=[name,'.wpa'];
    name2=[name,'.wap'];
    name3=[name,'.was'];
    name4=[name,'.wdr'];
... name5=[name,'.wds'];
... name6=[name,'.wcf'];
    name7=[name,'.wst'];
elseif (D~=1 & H==0)    % cambio de dia
    if(M<=9 & D<=9);name=['awac_',num2str(Y(2)),'0',num2str(M(2)),'0',num2str(D(2)),'0001'];end
    if(M<=9 & D>9);name=['awac_',num2str(Y(2)),'0',num2str(M(2)),num2str(D(2)),'0001'];end
    if(M>9 & D<=9);name=['awac_',num2str(Y(2)),num2str(M(2)),'0',num2str(D(2)),'0001'];end
    if(M>9 & D>9);name=['awac_',num2str(Y(2)),num2str(M(2)),num2str(D(2)),'0001'];end
    name1=[name,'.wpa'];
    name2=[name,'.wap'];
    name3=[name,'.was'];
    name4=[name,'.wdr'];
... name5=[name,'.wds'];
... name6=[name,'.wcf'];
    name7=[name,'.wst'];
end

% fidr: identificador de archivo para lectura
% fidw: identificador de archivo para escritura



%% Variables de entrada (Input variables)

href=0:23;
indice=find(H==href);
indice=indice-1;indice=href(indice);

% Corrientes. (Currents)
% Linea de encabezado del perfil. (Headline of the cast.)
mm=[];      % month (1-12)
dd=[];      % day (1-31)
yy=[];      % year
hh=[];      % hour (0-23)
mn=[];      % minute (0-59)
ss=[];      % second (0-59)
erc=[];     % error code
stc=[];     % status code
bat=[];     % battery bat (V)
ssp=[];     % sound speed (m/s)
hdg=[];     % heading (deg)
pth=[];     % pitch (deg)
rll=[];     % roll (deg)
prs=[];     % pressure (m)
tmp=[];     % temperature (deg C)
ai1=[];     % analog input #1
ai2=[];     % analog input #2
nob=[];     % number of beams
noc=[];     % number of depth cells

% Datos del perfil. 1 renglon de datos por cada celda de profundidad. (Cast data. One single row for each depth bin.)
cnb=[];     % cell number
dfh=[];     % distance from head (m)
fsp=[];     % current speed (m/s)
fdr=[];     % current direction (deg)
ve=[];      % east velocity (m/s)
vn=[];      % north velocity (m/s)
vu=[];      % up velocity (m/s)
amb1=[];    % amplitude beam1 (counts)
amb2=[];    % amplitude beam2 (counts)
amb3=[];    % amplitude beam3 (counts)

%Entrada en archivo 1 veces p/hora. (Login on file one time per hour.)

C=textscan(name,'%11s');C=C{1};C=char(C(1));
namew=[C,'.wpa'];               % variable que guarda el nombre del archivo de escritura para el perfil de corrientes. (Saves the write file name for the currents profile.)
fidr=fopen(name1);              % abre el archivo del perfil de corrientes (name1 = '.wpa'). (Opens the currents profile file (name1 = '.wpa') )
fidw=fopen(namew,'a+');         % abre un nuevo archivo para guardar los datos del perfil de corrientes. El archivo contendra un mes de datos. (Opens a new file to save on it the currents profile data, the file will have one month data)

while ~feof(fidr)
    tline=fgetl(fidr);ii=length(tline);
    if ii>90;sch=textscan(tline,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');end  % max. 93 caracteres
    if ii<90;dta=textscan(tline,'%f %f %f %f %f %f %f %f %f %f');end                             % max. 66 caracteres
    if indice==sch{4}
        if ii>90
            mm=[mm; sch{1}];dd=[dd; sch{2}];yy=[yy; sch{3}];hh=[hh; sch{4}];mn=[mn; sch{5}];ss=[ss; sch{6}];
            erc=[erc; sch{7}];stc=[stc; sch{8}];bat=[bat; sch{9}];ssp=[ssp; sch{10}];hdg=[hdg; sch{11}];pth=[pth; sch{12}];rll=[rll; sch{13}];
            prs=[prs; sch{14}];tmp=[tmp; sch{15}];ai1=[ai1; sch{16}];ai2=[ai2; sch{17}];nob=[nob; sch{18}];noc=[noc; sch{19}];
        elseif ii<90
            cnb=[cnb; dta{1}];dfh=[dfh; dta{2}];fsp=[fsp; dta{3}];fdr=[fdr; dta{4}];
            ve=[ve; dta{5}];vn=[vn; dta{6}];vu=[vu; dta{7}];
            amb1=[amb1; dta{8}];amb2=[amb2; dta{9}];amb3=[amb3; dta{10}];
        end
    end
   fprintf(fidw,) 
end

%SALVAR VARIABLES (BACKUP MENSUAL DATOS CRUDOS)
...save('filename','-ascii','cnb',...);


%% Variables de salida (Output variables)
% Estadisticas promedio de la corriente en la columna de agua. 
% (Average current statistics in the water column.)

%$ Eliminar el 10% de la columna de agua, relativo a la frontera oceano-atmosfera. 
%$ Confirmar que el dato de la direccion de la corriente, sea de 'donde
%$ proviene' y no 'hacia donde va', y su relacion con el Head,Pitch,Roll.
%$ Nortek proporciona la direccion de la Corriente 'Hacia', el Oleaje lo
%$ reporta 'De'.

prs=mean(prs);
tmp=mean(tmp);
ve=mean(ve);vn=mean(vn);vu=mean(vu);
vmag=sqrt(ve^2+vn^2+vu^2);
[theta,phi,r]=cart2sph(ve,vn,vu);
theta=theta*180/pi;

% 0<=theta<=90  ----->  90 - theta.
% 0>theta>=-180 ----->  90 - theta.
% 90<theta<=180 -----> 450 - theta.

if theta>=0 & theta<=90         % 0° a 90°
    theta=90-theta;
elseif theta<0 & theta>=-180    % 91° a 270°
    theta=90-theta;
elseif theta>90 & theta<=180    % 271° a 360°
    theta=450-theta;
end


%% Graficado (Presion, Temperatura, Velocidad, Direccion)
%% Graphics (Pressure, Temperature ,Veocity, Direction)

hidro=[yy mm dd hh prs tmp vmag theta];
dias=7;
horas=24;
vt=dias*horas;                                  % ventana de tiempo de la grafica (graphic time frame)
if k<vt
    fid2=fopen('hidrografia.dat','a');
    fprintf(fid2,'%f %f %f %f %f %f %f %f\n',hidro);
elseif k>=vt
    fid2=fopen('hidrografia.dat','r+');
    c=load('hidrografia.dat');
    frewind(fid2);
    for i=1:vt-1
        fprintf(fid2,'%f %f %f %f %f %f %f %f\n',c(i+1,:));
    end
    fprintf(fid2,'%f %f %f %f %f %f %f %f\n',hidro);
end

hidro=load('hidrografia.dat');
yy=hidro(:,1);mm=hidro(:,2);dd=hidro(:,3);hh=hidro(:,4); mn=zeros(size(hh));ss=zeros(size(hh));
prs=(:,5);tmp=(:,6);vmag=(:,7);theta=(:,8);
time=datenum(yy,mm,dd,hh,mn,ss);

figure(1)
[ax,h1,h2]=plotyy(time,prs,'.-b',time,tmp,'.-r','plot');
set(get(ax(1),'Ylabel'),'String','Left Y-axis')
set(get(ax(2),'Ylabel'),'String','Right Y-axis')
title('Temperatura y Nivel del mar en 21º25´32.402" N, 89º18´35.091" W')
datetick('x',19);
grid on

figure(2)
[ax,h1,h2]=plotyy(time,vmag,'.-b',time,theta,'.-r','plot');
set(get(ax(1),'Ylabel'),'String','Left Y-axis')
set(get(ax(2),'Ylabel'),'String','Right Y-axis')
title('Velocidad y Direccion de la corriente en 21º25´32.402" N, 89º18´35.091" W')
datetick('x',19);
grid on




%errorbar(T,E)
%namefigh=['boya',num2str(fix(clock))];

%% Respaldo Datos de salida
%% (Output data backup)
saveas(gcf,'namefigure','jpg')
if M
name=['awac',num2str(Y),'0',num2str(M),'.txt']
fprintf(name,'A','txt', \n \r)
save('d:\mymfiles\june10','vol','temp','-ASCII')

%% Cierre de Archivo
%% (Closing file)

fclose('all')
close all
quit



%{
im=find(prs~=max(prs)&prs~=min(prs));prs=mean(prs(im));
iend=length(fsp);k=length(mn);
j=iend/k;
mmfsp=[];mmfdr=[];
n=1;
%{
%n=1:j:iend-2;m=3:j:iend;
%k=1:iend/j;
%indice(1,k)=fsp(find(fsp(n:m)~=max(fsp(n:m))&fsp(n:m)~=min(fsp(n:m))));
}%
for i=1:k
    m=n+j;
    mfsp=fsp(n:m-1);
    im=find(mfsp~=max(mfsp)&mfsp~=min(mfsp));mfsp=mean(mfsp(im));mmfsp=[mmfsp;mfsp];
    ...im=find(mfsp==max(mfsp));im=im(1);im=find(mfsp==min(mfsp));
    ...mfsp=fsp(n:m-1);im=find(mfsp~=max(mfsp)&mfsp~=min(mfsp));mfsp=mean(mfsp(im));mmfsp=[mmfsp;mfsp];
    ...mfsp=fsp(n:m-1);mfsp=mean(mfsp(find(mfsp~=max(mfsp)&mfsp~=min(mfsp))));mmfsp=[mmfsp;mfsp];
    n=m;
end
}%
