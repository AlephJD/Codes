% Codigo que lee archivos en formato ASCII, generando datos estadisticos de
% las variables encontradas, y realizando promedios cada 'N' minutos para
% reducir el tamanio del archivo. Los resultados se grafican en una serie de
% tiempo de 'N' longitud (e.g. 3 meses, 1 dia, 12 horas).
% (Read ascii files, and calculates statistics of variables. Averages every 
% 'N' minutes to reduce file size. Results are plotted on a 'N' length time
% series. E.g.: 3 months, 1 day, 12 hours)


% PENDIENTES:   1) Actualizar 3 veces al dia la Figura.
%               2) Hacer un BackUp de los datos originales (crudos).
%               3) Hacer un BackUp de un archivo mensual con los promedios.

%% Lectura de Archivos
%% (Read files)
c=fix(clock);Y=c(1);M=c(2);D=c(3);H=c(4);MN=(5);S=c(6);
if M<=9;name=['PB_',num2str(Y),'0',num2str(M),num2str(D),'0001.wpa'];
else; name=['PB_',num2str(Y),num2str(M),num2str(D),'0001.wpa'];end
fid=fopen(name);

while tline~=-1
    tline=fgetl(fid);i=length(tline);
    if i>90
    tline=textscan(tline,'%3s %3s %5s %3s %3s %3s %2s %4s %5s %7s %6s %5s %5s %6s %6s %2s %2s %2s %2s');
    mm=tline{1};dd=tline{2};yy=tline{3};hh=tline{4};min=tline{5};ss=tline{6};
    ec=tline{7};sc=tline{8};bt=tline{9};ssp=tline{10};hdg=tline{11};pth=tline{12};rll=tline{13};
    press=tline{14};temp=tline{15};ai1=tline{16};ai2=tline{17};nob=tline{18};noc=tline{19};
    else
    tline=textscan(tline,'%2s %4s %6s %7s %6s %7s %7s %3s %3s %3s');
    cnum=tline{1};dhd=tline{2};spd=tline{3};dir=tline{4};
    vel_e=tline{5};vel_n=tline{6};vel_up=tline{7};
    amp_b1=tline{8};amp_b2=tline{9};amp_b3=tline{10};
    end
    
A=textscan(fid, '%s %12d %s %12d %12s %8s %d %d %d %d %d %f %f %s %f %s %12d %f %f %f %s');

%% Variables de entrada
%% (Input variables)
fecha=A{5};
hora=A{6};
ca1=A{7};
ca2=A{8};
ca3=A{9};
ca4=A{10};
ca5=A{11};
temp=A{12};
cond=A{13};
pira=A{15};
do=A{18};
orp=A{19};
ph=A{20};
wD=A{23};
wS=A{24};
aT=A{25};
humid=A{26};
press=A{27};
rA=A{28};
rD=A{29};
hT=A{30};
hV=A{31};
k=length(fecha);
n=0;

%% Variables de salida
%% (Output variables)
temp_m=[]; T=[]; E=[];

%% Procesado de Datos. Estadisticos
%% (Data processing. Basic statistics)
for i=1:k
    n=n+1;
    temp_m=[temp_m temp(i)];
    if n==10
        error=std(temp_m);
        temp_m=mean(temp_m);
        T=[T;temp_m]; E=[E error];
        n=0; temp_m=[];
    end
end

%% Graficado
%% (Graphs)
plot(T),ylabel('Temperatura gradC'),xlabel ('No. registro'),
%errorbar(T,E)
%namefigh=['boya',num2str(fix(clock))];

%% Respaldo de Datos de salida
%% (Output backup)
saveas(gcf,'namefigure','jpg')
if M
name=['awac',num2str(Y),'0',num2str(M),'.txt']
%fprintf(name,'A','txt', \n \r)
save('d:\\mymfiles\\june10','vol','temp','-ASCII')
end

%% Cierre
%% (Closing)
fclose('all')
close all
%quit

end
