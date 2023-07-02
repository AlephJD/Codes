% Modelo Numerico

%         Archivo que escribe en diferencias finitas
%         las ecuaciones de aguas someras en un sistema de
%   	  gravedad reducida (capa 1 1/2).

% PARAMETROS Y CONDICIONES INICIALES. 
 nx =210; ny=185;
 dx=2500;dy=dx;
 Rt=6.37e6;
 rho=1025;
 gr=0.015;
 ho=400;
 c = sqrt(gr*ho);
 nu=20.1; nu=nu*ho;        %Coef. Viscosidad Cinematica

% Habilita o deshabilita el cálculo de los terminos no lineales 
% en ecuaciones de momentum (ru) y continuidad (rh). 

ru = 1;rh = 1;
tf = 86400*200;        % Tiempo final
dt=0.1*dx/c
dt=200;     				% Diferencial de tiempo.
iend=round(tf/dt);			% Numero de iteraciones.	   
alpha=0.245;				% Coeficiente de Asselin-Robert: 0.05<=alpha<=0.1.



hh=meshgrid(1:nx,1:ny);
hh=zeros(size(hh));
uu=hh;vv=hh;
h(1:ny,1:nx,1)=hh;h(:,:,2)=h(:,:,1);h(:,:,3)=h(:,:,1);
u(1:ny,1:nx,1)=uu;u(:,:,2)=u(:,:,1);u(:,:,3)=u(:,:,1);
v(1:ny,1:nx,1)=vv;v(:,:,2)=v(:,:,1);v(:,:,3)=v(:,:,1);


% CORIOLIS

lat=22;omega=2*pi/(86400*(1-1/365.25));
fo=2*omega*sin(lat*pi/180);

T=2*pi/fo;
nt=round(T/dt);
T=nt*dt;fo=2*pi/T;
lat=180*asin(0.5*fo/omega)/pi;
Beta=0*(2*omega*cos(lat*pi/180))/Rt;

j=1:ny;i=1:nx;[i,j]=meshgrid(i,j);
fu=fo+Beta*(j-0.5)*dy;
fv=fo+Beta*(j-1)*dy;


periodo=86400; sk=5; fac=100;
x=1:nx;y=1:ny; x=(x-round(mean(x)))*dx;y=(y-round(mean(y)))*dy;
[xx,yy]=meshgrid(x,y);


seish=floor(6*60*60/dt);nw=-1;

% Construccion de un Remolino anticiclónico a partir de ciclostrofía.
% (Nota: puede prescribirse cualquier condición inicial.)


R00=67*dx;a00=1.20524;
RA=R00;kn=2*pi/RA;
rr=sqrt(xx.*xx+yy.*yy);
hh=h(:,:,1);hh=0*hh;uu=hh;vv=hh;
a0=a00/gr;hh=a0*(cos(2*pi*rr/RA)+1);
ii=find(rr>RA/2);hh(ii)=0;
rr=xx-dx/2;rr=sqrt(rr.*rr+yy.*yy);
uu=-4*gr*a0*kn^2*sinc(kn*rr/pi);
uu=sqrt(fo^2+uu)-fo;
ii=find(rr > RA/2);uu(ii)=0; % uu es la vel.angular para uu
uu=real(uu);
uu=-uu.*yy/2;
rr=xx+dy/2;rr=sqrt(rr.*rr+yy.*yy);
vv=-4*gr*a0*kn^2*sinc(kn*rr/pi);
vv=sqrt(fo^2+vv)-fo;
ii=find(rr>RA/2);vv(ii)=0;   
vv=real(vv);vv=vv.*xx/2;
hh=hh+ho;


h(:,:,1)=h(:,:,1)+hh;h(:,:,2)=h(:,:,1);h(:,:,3)=h(:,:,1);
u(:,:,1)=u(:,:,1)+uu;u(:,:,2)=u(:,:,1);u(:,:,3)=u(:,:,1);
v(:,:,1)=v(:,:,1)+vv;v(:,:,2)=v(:,:,1);v(:,:,3)=v(:,:,1);



% INICIA CICLO DE ITERACIONES.
for k=1:iend
    ind3=mod(k+1,3)+1;
    ind2=mod(k,3)+1;
    ind1=mod(k-1,3)+1;
     t=(k-1)*dt;
     n=n+1;

% Algoritmos para el cálculo en diferencias finitas de u, v y h.

uu=u(:,:,ind2);vv=v(:,:,ind2);hh=h(:,:,ind2); 
 j=2:ny-1;i=2:nx-1; 
% du/dt.
       uudx=uu(j,i);uudx=uudx.*(uu(j,i+1)-uu(j,i-1))/(2*dx);
       vudy=0.25*(vv(j,i)+vv(j+1,i)+vv(j+1,i-1)+vv(j,i-1));fvu=fu(j,i).*vudy;
       vudy=vudy.*(uu(j+1,i)-uu(j-1,i))/(2*dy);
       gpx=gr*(hh(j,i)-hh(j,i-1))/dx;
       nuu=nu*((u(j,i+1,ind1)-2*u(j,i,ind1)+u(j,i-1,ind1))/dx^2 +...
               (u(j+1,i,ind1)-2*u(j,i,ind1)+u(j-1,i,ind1))/dy^2);
       nuu=nuu./(h(j,i,ind1)+h(j,i-1,ind1))*0.5;
       u(j,i,ind3)=u(j,i,ind1)+2*dt*(fvu-ru*(uudx+vudy)-gpx+nuu);
% dv/dt.
       vvdy=vv(j,i).*(vv(j+1,i)-vv(j-1,i))/(2*dy);
       uvdx=0.25*(uu(j,i)+uu(j-1,i)+uu(j-1,i+1)+uu(j,i+1));fuv=fv(j,i).*uvdx;
       uvdx=uvdx.*(vv(j,i+1)-vv(j,i-1))/(2*dx);
       gpy =gr*(hh(j,i)-hh(j-1,i))/dy;
       nuu=nu*((v(j,i+1,ind1)-2*v(j,i,ind1)+v(j,i-1,ind1))/dx^2+...
                (v(j+1,i,ind1)-2*v(j,i,ind1)+v(j-1,i,ind1))/dy^2);
       nuu=nuu./(h(j,i,ind1)+h(j-1,i,ind1))*0.5;
       v(j,i,ind3)=v(j,i,ind1)+2*dt*(-fuv-ru*(uvdx+vvdy)-gpy+nuu);
       
% dh/dt
       udx=(uu(j,i+1)-uu(j,i))/dx;vdy=(vv(j+1,i)-vv(j,i))/dy;
       uhdx= 0.5*(uu(j,i+1)+uu(j,i)).*(hh(j,i+1)-hh(j,i-1))/(2*dx);
       vhdy= 0.5*(vv(j+1,i)+vv(j,i)).*(hh(j+1,i)-hh(j-1,i))/(2*dy);
       h(j,i,ind3)=h(j,i,ind1)-2*dt*(hh(j,i).*(udx+vdy)+rh*(uhdx+vhdy));

    
% CONDICIONES DE FRONTERA.
% Condición de frontera del campo de velocidad.
i=1:nx;
           % Frontera Sur.
           u(1, i,ind3)=u(2, i,ind3);      		% Deslizamiento Libre (DL)
           v(1, i ,ind3)=-v(3, i,ind3);      
           v(2, i,ind3)=0;                   	% Impenetrabilidad (IM)

           % Frontera Norte.
           u(ny, i,ind3)=u(ny-1, i,ind3); 	% DL
           v(ny, i,ind3)=0;                  	% IM

j=1:ny;
           % Front. Oeste.
           v(j,1,ind3)=v(j,2,ind3);      	% DL
           u(j,1,ind3)=-u(j,3,ind3);     
           u(j,2,ind3)=0;                    	% IM

           % Frontera Este.
           v(j,nx,ind3)=v(j,nx-1,ind3);  	% DL
           u(j,nx,ind3)=0;                   	% IM


% Condición de frontera del grosor de la capa.

           h(1,i,ind3)=ho; 			% Sur.
           h(ny,i,ind3)=ho;			% Norte.
           h(j,1,ind3)=ho;			% Oeste.
           h(j,nx,ind3)=ho;			% Este.

          
% Filtro de Asselin-Robert.

u(:,:,ind2)=u(:,:,ind2)+alpha*(u(:,:,ind3)+u(:,:,ind1)-2*u(:,:,ind2)); 
v(:,:,ind2)=v(:,:,ind2)+alpha*(v(:,:,ind3)+v(:,:,ind1)-2*v(:,:,ind2)); 
h(:,:,ind2)=h(:,:,ind2)+alpha*(h(:,:,ind3)+h(:,:,ind1)-2*h(:,:,ind2)); 

    if (mod(k,seish)==0) ;
      nw=nw+1;
      cnw=sprintf('%4.4i',nw);
      hh=h(:,:,ind3);uu=u(:,:,ind3);vv=v(:,:,ind3);
      ii=find(isnan(hh));if length(ii)>0 ; disp('hay nans');return;end
      tiemp=k*dt/(24*60*60);% el tiempo en dias
      hh=h(:,:,ind2);uu=u(:,:,ind2);vv=v(:,:,ind2);
      
      eval(['save  dats' cnw '  k tiemp hh uu vv '])
      figure(1);clf;pcolor(vv);shading interp;caxis([-1 1])
      hold;title(num2str(tiemp));
        %quiver(xx(2:sk:end,2:sk:end),yy(2:sk:end,2:sk:end),u(2:sk:end,2:sk:end,ind3)*fac,v(2:sk:end,2:sk:end,ind3)*fac,0,'k')
        %caxis([300 700]);
      colorbar;drawnow;
    end
  end