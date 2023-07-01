% Calcula profundidad del fondo a la que deben ser lanzados los anclajes de
% los hobos para quedar a 5m debajo del nivel bajo de marea.
% (Bottom depth calculation for each hobo anchor. Each one must be 5m 
% below low tide level.)

prof_hobo=20.3; % altura en m del anclaje de hobo, del muerto a la parte mas alta de las boyas.
Aboya= 3; % profundidad de la boya debajo del m’nimo del nivel del mar
to=datenum(2011,12,6,9,0,0); % hora de lanzamiento del anclaje en cuestion

close all

% Carga los datos de marea
% (Load tide data)
dat=load('ens_marea_2011-12(2).prd');
t=datenum(dat(:,1),dat(:,2),dat(:,3),dat(:,4),dat(:,5),dat(:,5)*0);
Ah=dat(:,6)/1000; % nivel del mar respecto al nivel del mar medio en m
Amin=abs(min(Ah(:))); %distancia entre nivel de mar medio y mínimo bajamar durante el 2011-2012.
ind= find(abs(t-to)==min(abs(t-to)));

% Carga los bajamares y pleamares de marea
dat=load('ens_maxymin_2011-12(2).prd');
t2=datenum(dat(:,1),dat(:,2),dat(:,3),dat(:,4),dat(:,5),dat(:,5)*0);
A= dat(:,6)/1000;
mins=A(A<0);
maxs=A(A>0);
Amin2=abs(mean(mins)); % distancia entre nivel de mar medio y bajamar promedio para 2011-2012

% usando el minimo bajamar
prof= prof_hobo+Aboya+Amin+Ah(ind);
prof_boya=Aboya+Amin+Ah;
mean_prof= prof_hobo+Aboya+Amin;

% usando el promedio de los bajamares
prof2= prof_hobo+Aboya+Amin2+Ah(ind);
prof_boya2=Aboya+Amin2+Ah;
mean_prof2= prof_hobo+Aboya+Amin2;

ind3=find(t>=datenum(2011,12,5,8,0,0) & t<=datenum(2011,12,6,23,0,0));

% Grapics
figure
plot(t(ind3),Ah(ind3)); hold on
plot(t(ind3),Ah(ind3)*0)
plot(t(ind),Ah(ind),'*')
ax=axis; axis([t(ind3(1)) t(ind3(end)) ax(3:4)])
set(gca,'xtick',t(ind3(1):2:ind3(end)))
datetick('x', 'HH:MM' ,'keepticks','keeplimits');
title('Mareas 5 y 6 de diciembre 2011')
grid on
orient landscape

figure
subplot(2,1,1)
plot(t,prof_boya); 
ax=axis; axis([t(1) t(end) ax(3:4)])
datetick('x','mmm','keeplimits')
title(['prof. boya, usando Aboya= ' num2str(Aboya) ' m bajo el mínimo nivel del mar'])
ylabel(['media= ' num2str(mean(prof_boya), '%2.1f')])
subplot(2,1,2)
plot(t,prof_boya2);
ax=axis; axis([t(1) t(end) ax(3:4)])
datetick('x','mmm','keeplimits')
title(['prof. boya, usando Aboya= ' num2str(Aboya) ' m bajo el bajamar medio'])
ylabel(['media= ' num2str(mean(prof_boya2), '%2.1f')])

disp(' ')
disp(' ')
disp(' ')
disp('Usando el mínimo bajamar de todo el año')
disp(['prof. fondo al tiempo ' datestr(to) '  ' num2str(prof, '%2.1f') ' m'])
disp(['prof. boya media ' num2str(mean(prof_boya),'%2.1f') ' min ' num2str(min(prof_boya),'%2.1f ') ' max ' num2str(max(prof_boya),'%2.1f ')])
disp(['prof. fondo media ' num2str(mean_prof, '%2.1f')])
disp(' ')
disp('Usando el bajamar medio')
disp(['prof. fondo al tiempo ' datestr(to) '  ' num2str(prof2, '%2.1f') ' m'])
disp(['prof. boya media ' num2str(mean(prof_boya2),'%2.1f') ' min ' num2str(min(prof_boya2),'%2.1f ') ' max ' num2str(max(prof_boya2),'%2.1f ')])
disp(['prof. fondo media ' num2str(mean_prof2, '%2.1f')])
