% Programa que realiza los calculos numericos de las 
% salidas obtenidas de "ModeloNumerico".

load dots0001; 
hhprev=hh;vprev=vv;uprev=uu;EprevD=NaN;EprevS=NaN;

            
dtt=3600;   
ho=400;
nu=20.1; nu=nu*ho;
nx =210; ny=185;dx=2500;dy=dx;
   Rt=6.37e6;rho=1025;gr=0.015;ho=400;c = sqrt(gr*ho);
   lat=22;omega=2*pi/(86400*(1-1/365.25));fo=2*omega*sin(lat*pi/180);
   Beta=(2*omega*cos(lat*pi/180))/Rt;
   Beta=0;
   a=c/fo;

x=1:nx;y=1:ny;
x=(x-round(mean(x)))*dx;y=(y-round(mean(y)))*dy;
[xx,yy]=meshgrid(x,y);

iend=1920;
 j=2:4:ny-1;i=3:4:nx-1;fac=200000;
     jp=2:7:ny-1;ip=2:7:nx-1;

% Para las cantidades de interes en el Sistema %
    volD=[];ecD=[];epD=[];marD=[];mapD=[];           % 'D',Dominio.
    volS=[];ecS=[];epS=[];marS=[];mapS=[];tti=[];    % 'S',Subdominio
% Para las diferenciales temporales de esas cantidades y su equivalente en
% Integrales de 'dominio'.
    dEdtD=[];int1D=[];int2D=[];int3D=[];int4D=[];intBerD=[];
    dEdtS=[];int1S=[];int2S=[];int3S=[];int4S=[];intBerS=[];
    
    dtvD=[];dtmarD=[];dtmapD=[];intvD=[];LRFD=[]; LRCLD=[]; LRCAD=[]; LRPD=[]; LRVD=[]; LRCD=[]; LPD=[];
    dtvS=[];dtmarS=[];dtmapS=[];intvS=[];LRFS=[]; LRCLS=[]; LRCAS=[]; LRPS=[]; LRVS=[]; LRCS=[]; LPS=[];
    intmarD=[];intmatD=[];
    intmarS=[];intmatS=[];
% Indices para integracion en todo el Dominio.
    ice=2;icf=nx-1;jce=2;jcf=ny-1; % AQUI
    ii=ice:icf;jj=jce:jcf;         % COMO primer intento
% Indices para integracion en el Subdominio. 
    ixe=60;ixf=150;jye=50;jyf=135; 
    ifp=ixe:ixf;jfp=jye:jyf;       

lats=24+yy/111000;
lons=-90+xx/111000;fac=fac/111000;fac=fac/5;

% ucprev y vcprev es la velocidad centrada en h para (t-1) %
% (Las velocidades centradas quedan enmarcadas dentro del Dominio)
    hrprev=hhprev(jj,ii);
    ucprev=(uprev(jj,ii)+uprev(jj,ii+1))/2; 
    vcprev=(vprev(jj,ii)+vprev(jj+1,ii))/2;

    hsprev=hhprev(jfp,ifp);
    usprev=(uprev(jfp,ifp)+uprev(jfp,ifp+1))/2;
    vsprev=(vprev(jfp,ifp)+vprev(jfp+1,ifp))/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	for k=0:iend
    cnw=sprintf('%4.4i',k);
    eval(['load  dats' cnw ]); 
   
   kfig=10;if kfig
         figure(1);clf
         pcolor(lons,lats,hh);shading interp;
         hold;title(num2str(tiemp));
         quiver(lons(jp,ip),lats(jp,ip),uu(jp,ip)*fac,vv(jp,ip)*fac,0,'w')
         %caxis([360 440]);
         caxis([360 820]);
         %plot(bn(:,2),bn(:,1),'k','LineWidth',1.5);
         colorbar;drawnow;
     
           end;% del kfig


    % DOMINIO %
           % uc y vc es la velocidad centrada en h para (t+1).
           uc=(uu(jj,ii)+uu(jj,ii+1))/2;
           vc=(vv(jj,ii)+vv(jj+1,ii))/2;    
           hr=hh(jj,ii);
           Vol=sum(hr(:))*dx*dy;
           EcD=hr.*(uc.*uc+vc.*vc);EcD=sum(EcD(:));  
           EpD=hr.*hr;EpD=sum(EpD(:));
           xc=xx(jj,ii);yc=yy(jj,ii);       
           a=hr;b=xc.*vc-yc.*uc;a=sum(a.*b);
           MARD=rho*sum(a)*dx*dy;   
           r2=xc.*xc+yc.*yc;
           MAPD=rho*0.5*fo*sum(sum(r2.*hr))*dx*dy;
           
        EcD = 0.5*rho*dx*dy*EcD;
		EpD = 0.5*rho*gr*dx*dy*EpD;
   volD=[volD;Vol];ecD=[ecD;EcD];epD=[epD;EpD];marD=[marD;MARD];mapD=[mapD;MAPD];
        matD=marD+mapD;
    % SUBDOMINIO %		
           us=(uu(jfp,ifp)+uu(jfp,ifp+1))/2;
           vs=(vv(jfp,ifp)+vv(jfp+1,ifp))/2;    
           hs=hh(jfp,ifp);
           Vol=sum(hs(:))*dx*dy;
           EcS=hs.*(us.*us+vs.*vs);EcS=sum(EcS(:));  
           EpS=hs.*hs;EpS=sum(EpS(:));
           xs=xx(jfp,ifp);ys=yy(jfp,ifp);       
           a=hs;b=xs.*vs-ys.*us;a=sum(a.*b);
           MARS=rho*sum(a)*dx*dy;
           r2=xs.*xs+ys.*ys;
           MAPS=rho*0.5*fo*sum(sum(r2.*hs))*dx*dy;
           
		EcS = 0.5*rho*dx*dy*EcS;
		EpS = 0.5*rho*gr*dx*dy*EpS;
   volS=[volS;Vol];ecS=[ecS;EcS];epS=[epS;EpS];marS=[marS;MARS];mapS=[mapS;MAPS];
   tti=[tti;tiemp];

                            % DIFERENCIALES DE TIEMPO 'D/Dt' %


    % MOMENTO ANGULAR 'ANTERIOR' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Dominio.
        % Relativo %
    marprevD=rho*sum(sum(hrprev.*(xc.*vcprev-yc.*ucprev)))*dx*dy;
        % Planetario %
    mapprevD=rho*0.5*fo*sum(sum((xc.*xc+yc.*yc).*hrprev))*dx*dy;
    % Subdominio.
        % Relativo %
    marprevS=rho*sum(sum(hsprev.*(xs.*vsprev-ys.*usprev)))*dx*dy;
        % Planetario %
    mapprevS=rho*0.5*fo*sum(sum((xs.*xs+ys.*ys).*hsprev))*dx*dy;    
    
    % VOLUMEN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Dominio.
    dtV=sum(sum(hr-hrprev))*dx*dy/dtt;
dtvD=[dtvD dtV];   
    % Subdominio.
    dtV=sum(sum(hs-hsprev))*dx*dy/dtt;  
dtvS=[dtvS dtV];

    % ENERGIA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Dominio.
     EED=EcD+EpD;DEDt=(EED-EprevD)/dtt;
     dEdtD=[dEdtD DEDt];   
    % Subdominio.
     EES=EcS+EpS;DEDt=(EES-EprevS)/dtt;
     dEdtS=[dEdtS DEDt];   


    % MOMENTO ANGULAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Dominio.
        % Relativo %
    MAR= MARD-marprevD;
        % Planetario %
    MAP= MAPD-mapprevD;

dtmarD=[dtmarD MAR/dtt];       
dtmapD=[dtmapD MAP/dtt];   dtmatD=dtmarD+dtmapD;
    % Subdominio.
        % Relativo %
    MAR= MARS-marprevS;
        % Planetario %
    MAP= MAPS-mapprevS;

dtmarS=[dtmarS MAR/dtt];       
dtmapS=[dtmapS MAP/dtt];   dtmatS=dtmarS+dtmapS;

    
% Promedios de u,v,h en el tiempo. [(t+1)+(t-1)]/2 = t
    hp=(hh+hhprev)/2; hhprev=hh;
    vp=(vv+vprev)/2;  vprev=vv;
    up=(uu+uprev)/2;  uprev=uu;

    hrprev=hr;ucprev=uc;vcprev=vc;
    hsprev=hs;usprev=us;vsprev=vs;    
    EprevD=EED;EprevS=EES;    
    
    
                            % INTEGRALES DE 'DOMINIO' %
    % VOLUMEN %
% Dominio.    
int= -(-sum((hp(jce-1,ii)+hp(jce,ii)).*vp(jce,ii))...
       +sum((hp(jcf,ii)+hp(jcf+1,ii)).*vp(jcf+1,ii))...
       -sum((hp(jj,ice-1)+hp(jj,ice)).*up(jj,ice))...
       +sum((hp(jj,icf)+hp(jj,icf+1)).*up(jj,icf+1)) )*dx/2;
     intvD=[intvD int];        
% Subdominio.
int= -(-sum((hp(jye-1,ifp)+hp(jye,ifp)).*vp(jye,ifp))...
       +sum((hp(jyf,ifp)+hp(jyf+1,ifp)).*vp(jyf+1,ifp))...
       -sum((hp(jfp,ixe-1)+hp(jfp,ixe)).*up(jfp,ixe))...
       +sum((hp(jfp,ixf)+hp(jfp,ixf+1)).*up(jfp,ixf+1)) )*dx/2;
     intvS=[intvS int];    
    
    % ENERGIA %
% Dominio %     
uh=(up(jce-1:jcf+1,ice-1:icf)+up(jce-1:jcf+1,ice:icf+1))*0.5;uh=[uh up(:,icf+1)];
vh=(vp(jce-1:jcf,ice-1:icf+1)+vp(jce:jcf+1,ice-1:icf+1))*0.5;vh=[vp(jcf+1,:);vh];

           Ec=hp.*(uh.*uh+vh.*vh);
           Ep=hp.*hp;
           Ec = 0.5*rho*Ec;
		   Ep = 0.5*rho*gr*Ep;
           B=Ec+2*Ep;

int1=  -( -sum(((B(jce-1,ii)+B(jce,ii))).*vp(jce,ii))...
          +sum(((B(jcf,ii)+B(jcf+1,ii))).*vp(jcf+1,ii))...
          -sum(((B(jj,ice-1)+B(jj,ice))).*up(jj,ice))...
          +sum(((B(jj,icf)+B(jj,icf+1))).*up(jj,icf+1)) )*dx/2;
    int1D=[int1D int1];
    
    ech=0.5*(uh.*uh+vh.*vh);
    decs=(ech(jce,ii)-ech(jce-1,ii))/dy; decn=(ech(jcf+1,ii)-ech(jcf,ii))/dy;
    deco=(ech(jj,ice)-ech(jj,ice-1))/dx; dece=(ech(jj,icf+1)-ech(jj,icf))/dx;

int2=  ( -sum( (hp(jce-1,ii)+hp(jce,ii)).*decs)...
         +sum( (hp(jcf,ii)+hp(jcf+1,ii)).*decn)...
         -sum( (hp(jj,ice-1)+hp(jj,ice)).*deco)...
         +sum( (hp(jj,icf)+hp(jj,icf+1)).*dece) )*dx/2;
    int2D=[int2D int2];
    
    dudx=(uh(jj,ii+1)-uh(jj,ii-1))/2*dx;dudx2=dudx.*dudx;
    dudy=(uh(jj+1,ii)-uh(jj-1,ii))/2*dy;dudy2=dudy.*dudy;
    dvdx=(vh(jj,ii+1)-vh(jj,ii-1))/2*dx;dvdx2=dvdx.*dvdx;
    dvdy=(vh(jj+1,ii)-vh(jj-1,ii))/2*dy;dvdy2=dvdy.*dvdy;
    
int3= -(sum(sum(hp(jj,ii).*(dudx2+dudy2+dvdx2+dvdy2)) ))*dx*dy;
    int3D=[int3D int3];

    dhdx=(hp(jj,ii+1)-hp(jj,ii-1))/2*dx;
    dhdy=(hp(jj+1,ii)-hp(jj-1,ii))/2*dy;
    
int4= -(sum(sum(uh(jj,ii).*(dhdx.*dudx+dhdy.*dudy)+vh(jj,ii).*(dhdx.*dvdx+dhdy.*dvdy)) ))*dx*dy;
    int4D=[int4D int4];    

    intBerD=[intBerD int1+nu*(int2+int3+int4)];  


% Subdominio %
uh=(up(jye-1:jyf+1,ixe-1:ixf)+up(jye-1:jyf+1,ixe:ixf+1))*0.5;uh=[uh up(jye-1:jyf+1,ixf+1)];
vh=(vp(jye-1:jyf,ixe-1:ixf+1)+vp(jye:jyf+1,ixe-1:ixf+1))*0.5;vh=[vp(jyf+1,ixe-1:ixf+1);vh];

           Ec=hp(jye-1:jyf+1,ixe-1:ixf+1).*(uh.*uh+vh.*vh);
           Ep=hp(jye-1:jyf+1,ixe-1:ixf+1).*hp(jye-1:jyf+1,ixe-1:ixf+1);
           Ec = 0.5*rho*Ec;
		   Ep = 0.5*rho*gr*Ep;
           B=Ec+2*Ep;
[j,i]=size(B); i=2:i-1;j=2:j-1;
           
int1=  -( -sum(((B(1,i)+B(2,i))).*vp(jye,ifp))...
          +sum(((B(end-1,i)+B(end,i))).*vp(jyf+1,ifp))...
          -sum(((B(j,1)+B(j,2))).*up(jfp,ixe))...
          +sum(((B(j,end-1)+B(j,end))).*up(jfp,ixf+1)) )*dx/2;
    int1S=[int1S int1];
    
    ech=0.5*(uh.*uh+vh.*vh);
    decs=(ech(2,i)-ech(1,i))/dy; decn=(ech(end,i)-ech(end-1,i))/dy;
    deco=(ech(j,2)-ech(j,1))/dx; dece=(ech(j,end)-ech(j,end-1))/dx;

int2=  ( -sum( (hp(jye-1,ifp)+hp(jye,ifp)).*decs)...
         +sum( (hp(jyf,ifp)+hp(jyf+1,ifp)).*decn)...
         -sum( (hp(jfp,ixe-1)+hp(jfp,ixe)).*deco)...
         +sum( (hp(jfp,ixf)+hp(jfp,ixf+1)).*dece) )*dx/2;
    int2S=[int2S int2];     

    dudx=(uh(j,i+1)-uh(j,i-1))/2*dx;dudx2=dudx.*dudx;
    dudy=(uh(j+1,i)-uh(j-1,i))/2*dy;dudy2=dudy.*dudy;
    dvdx=(vh(j,i+1)-vh(j,i-1))/2*dx;dvdx2=dvdx.*dvdx;
    dvdy=(vh(j+1,i)-vh(j-1,i))/2*dy;dvdy2=dvdy.*dvdy;
    
int3= -(sum(sum(hp(jfp,ifp).*(dudx2+dudy2+dvdx2+dvdy2)) ))*dx*dy;
    int3S=[int3S int3];
    
    dhdx=(hp(jfp,ifp+1)-hp(jfp,ifp-1))/2*dx;
    dhdy=(hp(jfp+1,ifp)-hp(jfp-1,ifp))/2*dy;
    
int4= -(sum(sum(uh(j,i).*(dhdx.*dudx+dhdy.*dudy)+vh(j,i).*(dhdx.*dvdx+dhdy.*dvdy)) ))*dx*dy;
    int4S=[int4S int4];

    intBerS=[intBerS int1+nu*(int2+int3+int4)];  
    
          
    % Orden de integracion de fronteras: Sur + Norte + Oeste + Este.

    % MOMENTO ANGULAR RELATIVO(r) de terminos No Lineales (FLUJO DE MOMENTO ANGULAR relativo): -sum[k.(rxv)*h*(v.n)]dl.   [kg*m2*s-2]
    % Dominio.    
LrfD= -rho*( -sum( (hp(jce-1,ii)+hp(jce,ii)).*xx(jce,ii).*vp(jce,ii).^2)...
             +sum( (hp(jcf,ii)+hp(jcf+1,ii)).*xx(jcf+1,ii).*vp(jcf+1,ii).^2)...
             +sum( (hp(jj,ice-1)+hp(jj,ice)).*yy(jj,ice).*up(jj,ice).^2)...
             -sum( (hp(jj,icf)+hp(jj,icf+1)).*yy(jj,icf+1).*up(jj,icf+1).^2))*dx/2;
     LRFD=[LRFD LrfD];
    % Subdominio.    
LrfS= -rho*( -sum( (hp(jye-1,ifp)+hp(jye,ifp)).*xx(jye,ifp).*vp(jye,ifp).^2)...
             +sum( (hp(jyf,ifp)+hp(jyf+1,ifp)).*xx(jyf+1,ifp).*vp(jyf+1,ifp).^2)...
             +sum( (hp(jfp,ixe-1)+hp(jfp,ixe)).*yy(jfp,ixe).*up(jfp,ixe).^2)...
             -sum( (hp(jfp,ixf)+hp(jfp,ixf+1)).*yy(jfp,ixf+1).*up(jfp,ixf+1).^2))*dx/2;
    LRFS=[LRFS LrfS];

    % FORMA ORIGINAL DEL TERMINO DE CORIOLIS SIN 'DESCOMPONER': -fo*sum(h*(r.v))dA %  [kg*m2*s-2]
    % Dominio.
uh=(up(jj,ii)+up(jj,ice+1:icf+1))*0.5;
vh=(vp(jj,ii)+vp(jce+1:jcf+1,ii))*0.5;
LrCD= -rho*fo*sum(sum(hp(jj,ii).*(xc.*uh+yc.*vh)))*dx*dy;
    LRCD=[LRCD LrCD];
    % Subdominio.
uh=(up(jfp,ifp)+up(jfp,ixe+1:ixf+1))*0.5;
vh=(vp(jfp,ifp)+vp(jye+1:jyf+1,ifp))*0.5;
LrCS= -rho*fo*sum(sum(hp(jfp,ifp).*(xs.*uh+ys.*vh)))*dx*dy;
    LRCS=[LRCS LrCS];
    
    % MOMENTO ANGULAR de Coriolis(f) evaluado en Linea:-sum[f*h*(r.v)*(r.n)]dl.  [kg*m2*s-2]
    % Dominio.
LrClD= -rho*fo*(-sum( (hp(jce-1,ii)+hp(jce,ii)).*((yy(jce-1,ii)+yy(jce,ii))*0.5).^2.*vp(jce,ii))...
                +sum( (hp(jcf,ii)+hp(jcf+1,ii)).*((yy(jcf,ii)+yy(jcf+1,ii))*0.5).^2.*vp(jcf+1,ii))...
                -sum( (hp(jj,ice-1)+hp(jj,ice)).*((xx(jj,ice-1)+xx(jj,ice))*0.5).^2.*up(jj,ice))...
                +sum( (hp(jj,icf)+hp(jj,icf+1)).*((xx(jj,icf)+xx(jj,icf+1))*0.5).^2.*up(jj,icf+1)) )*dx/2;
       LRCLD=[LRCLD LrClD];
    % Subdominio.
LrClS= -rho*fo*(-sum( (hp(jye-1,ifp)+hp(jye,ifp)).*((yy(jye-1,ifp)+yy(jye,ifp))*0.5).^2.*vp(jye,ifp))...
                +sum( (hp(jyf,ifp)+hp(jyf+1,ifp)).*((yy(jyf,ifp)+yy(jyf+1,ifp))*0.5).^2.*vp(jyf+1,ifp))...
                -sum( (hp(jfp,ixe-1)+hp(jfp,ixe)).*((xx(jfp,ixe-1)+xx(jfp,ixe))*0.5).^2.*up(jfp,ixe))...
                +sum( (hp(jfp,ixf)+hp(jfp,ixf+1)).*((xx(jfp,ixf)+xx(jfp,ixf+1))*0.5).^2.*up(jfp,ixf+1)) )*dx/2;
        LRCLS=[LRCLS LrClS];
       
    % MOMENTO ANGULAR de Coriolis(f) evaluado en Area: sum[f*(r.nabla)*h*(r.v)]dA.  [kg*m2*s-2]
    % Dominio.
uh=(up(jce-1:jcf+1,ice-1:icf)+up(jce-1:jcf+1,ice:icf+1))*0.5;uh=[uh up(:,icf+1)];xu=xx(jce-1:jcf+1,ice-1:icf+1).*uh;
vh=(vp(jce-1:jcf,ice-1:icf+1)+vp(jce:jcf+1,ice-1:icf+1))*0.5;vh=[vp(jcf+1,:);vh];yv=yy(jce-1:jcf+1,ice-1:icf+1).*vh;
hrv=hp(jce-1:jcf+1,ice-1:icf+1).*(xu+yv);
[j,i]=size(hrv); i=2:i-1; j=2:j-1;
dxhrv=(hrv(j,i+1)-hrv(j,i-1))/(2*dx);
dyhrv=(hrv(j+1,i)-hrv(j-1,i))/(2*dy);

LrCAD= rho*fo*( sum(sum(xc.*dxhrv+yc.*dyhrv)) )*dx*dy;
        LRCAD=[LRCAD LrCAD];
    % Subdominio.
uh=(up(jye-1:jyf+1,ixe-1:ixf)+up(jye-1:jyf+1,ixe:ixf+1))*0.5;uh=[uh up(jye-1:jyf+1,ixf+1)];xu=xx(jye-1:jyf+1,ixe-1:ixf+1).*uh;
vh=(vp(jye-1:jyf,ixe-1:ixf+1)+vp(jye:jyf+1,ixe-1:ixf+1))*0.5;vh=[vp(jyf+1,ixe-1:ixf+1);vh];yv=yy(jye-1:jyf+1,ixe-1:ixf+1).*vh;
hrv=hp(jye-1:jyf+1,ixe-1:ixf+1).*(xu+yv);
[j,i]=size(hrv); i=2:i-1; j=2:j-1;
dxhrv=(hrv(j,i+1)-hrv(j,i-1))/(2*dx);
dyhrv=(hrv(j+1,i)-hrv(j-1,i))/(2*dy);

LrCAS= rho*fo*( sum(sum(xs.*dxhrv+ys.*dyhrv)) )*dx*dy;
        LRCAS=[LRCAS LrCAS];
    
    % MOMENTO ANGULAR(r) de Presion Inviscida: sum[(0.5*gr*h^2)*r.dl].   [kg*m2*s-2]
    % Dominio.    
LrpD= rho*0.5*gr*(  sum( xx(jce,ii).*((hp(jce-1,ii)+hp(jce,ii))*0.5).^2)...
                   -sum( xx(jcf+1,ii).*((hp(jcf,ii)+hp(jcf+1,ii))*0.5).^2)...
                   -sum( yy(jj,ice).*((hp(jj,ice-1)+hp(jj,ice))*0.5).^2)...
                   +sum( yy(jj,icf+1).*((hp(jj,icf)+hp(jj,icf+1))*0.5).^2) )*dx;
          LRPD=[LRPD LrpD];
    % Subdominio.    
LrpS= rho*0.5*gr*(  sum( xx(jye,ifp).*((hp(jye-1,ifp)+hp(jye,ifp))*0.5).^2)...
                   -sum( xx(jyf+1,ifp).*((hp(jyf,ifp)+hp(jyf+1,ifp))*0.5).^2)...
                   -sum( yy(jfp,ixe).*((hp(jfp,ixe-1)+hp(jfp,ixe))*0.5).^2)...
                   +sum( yy(jfp,ixf+1).*((hp(jfp,ixf)+hp(jfp,ixf+1))*0.5).^2) )*dx;
          LRPS=[LRPS LrpS];

    % MOMENTO ANGULAR(r) VISCOSO (SIN 'DESCOMPONER'): nu*sum[k.(r x h*Lap(v))]dA.  [kg*m2*s-2]
    % Dominio.    
    % (Estas velocidades centradas poseen dimensiones de la matriz 'original' (210,185))
uh=(up(jce-1:jcf+1,ice-1:icf)+up(jce-1:jcf+1,ice:icf+1))*0.5;uh=[uh up(:,icf+1)];
vh=(vp(jce-1:jcf,ice-1:icf+1)+vp(jce:jcf+1,ice-1:icf+1))*0.5;vh=[vp(jcf+1,:);vh];

[j,i]=size(vh);i=2:i-1;j=2:j-1;
dx2u=(uh(j,i+1)+uh(j,i-1)-2*uh(j,i))/dx^2; dy2u=(uh(j+1,i)+uh(j-1,i)-2*uh(j,i))/dy^2;
dx2v=(vh(j,i+1)+vh(j,i-1)-2*vh(j,i))/dx^2; dy2v=(vh(j+1,i)+vh(j-1,i)-2*vh(j,i))/dy^2;
LrvD= rho*nu*( sum(sum( hp(jj,ii).*(xc.*(dx2v+dy2v)-yc.*(dx2u+dy2u)) )) )*dx*dy;

    LRVD=[LRVD LrvD];
    % Subdominio.    
uh=(up(jye-1:jyf+1,ixe-1:ixf)+up(jye-1:jyf+1,ixe:ixf+1))*0.5;uh=[uh up(jye-1:jyf+1,ixf+1)];
vh=(vp(jye-1:jyf,ixe-1:ixf+1)+vp(jye:jyf+1,ixe-1:ixf+1))*0.5;vh=[vp(jyf+1,ixe-1:ixf+1);vh];

[j,i]=size(vh);i=2:i-1;j=2:j-1;
dx2u=(uh(j,i+1)+uh(j,i-1)-2*uh(j,i))/dx^2; dy2u=(uh(j+1,i)+uh(j-1,i)-2*uh(j,i))/dy^2;
dx2v=(vh(j,i+1)+vh(j,i-1)-2*vh(j,i))/dx^2; dy2v=(vh(j+1,i)+vh(j-1,i)-2*vh(j,i))/dy^2;
LrvS= rho*nu*( sum(sum(hp(jfp,ifp).*(xs.*(dx2v+dy2v)-ys.*(dx2u+dy2u)) )) )*dx*dy;
    LRVS=[LRVS LrvS];
    
    % MOMENTO ANGULAR PLANETARIO(p) plano-f (Lt=Lr+Lp) evaluado en Linea:-0.5*f*sum[r^2*h*(v.n)]dl; [r^2=x^2+y^2].   [kg*m2*s-2]
    % Dominio.    
LpD= -rho*0.5*fo*( -sum( (xx(jce,ii).^2+((yy(jce-1,ii)+yy(jce,ii))*0.5).^2).*(hp(jce-1,ii)+hp(jce,ii)).*vp(jce,ii))...
                   +sum( (xx(jcf+1,ii).^2+((yy(jcf,ii)+yy(jcf+1,ii))*0.5).^2).*(hp(jcf,ii)+hp(jcf+1,ii)).*vp(jcf+1,ii))...
                   -sum( (((xx(jj,ice-1)+xx(jj,ice))*0.5).^2+yy(jj,ice).^2).*(hp(jj,ice-1)+hp(jj,ice)).*up(jj,ice))...
                   +sum( (((xx(jj,icf)+xx(jj,icf+1))*0.5).^2+yy(jj,icf+1).^2).*(hp(jj,icf)+hp(jj,icf+1)).*up(jj,icf+1)))*dx/2;
          LPD=[LPD LpD];
    % Subdominio.    
LpS= -rho*0.5*fo*( -sum( (xx(jye,ifp).^2+((yy(jye-1,ifp)+yy(jye,ifp))*0.5).^2).*(hp(jye-1,ifp)+hp(jye,ifp)).*vp(jye,ifp))...
                   +sum( (xx(jyf+1,ifp).^2+((yy(jyf,ifp)+yy(jyf+1,ifp))*0.5).^2).*(hp(jyf,ifp)+hp(jyf+1,ifp)).*vp(jyf+1,ifp))...
                   -sum( (((xx(jfp,ixe-1)+xx(jfp,ixe))*0.5).^2+yy(jfp,ixe).^2).*(hp(jfp,ixe-1)+hp(jfp,ixe)).*up(jfp,ixe))...
                   +sum( (((xx(jfp,ixf)+xx(jfp,ixf+1))*0.5).^2+yy(jfp,ixf+1).^2).*(hp(jfp,ixf)+hp(jfp,ixf+1)).*up(jfp,ixf+1)))*dx/2;
          LPS=[LPS LpS];
   
          
   intmarD=[intmarD LrfD+LrClD+LrCAD+LrpD+LrvD];   intmatD=[intmatD LrfD+LrpD+LrvD+LpD];
   intmarS=[intmarS Lr(6)] % son consistentes con los argumentos de energía y fricción.  
% III.2.   Momento angular.
% El postulado relevante de esta tesis es la noción que las