% Codigo que permite la apertura y lectura de archivos de ADCP (Proyecto Xcambo4)
% en formato .TXT, y posteriormente salva una base de datos por variables de
% los parametros.
% (Allows opening and reading of Project Xcambo4 ADCP files. Makes a
% database of the new ADCP parameters.)

% Elaborado por: Aleph Jimenez.
% Para: Laboratorio de Procesos Costeros y Oceanografia Fisica (LAPCOF)
%       del Centro de Investigacion y de Estudios Avanzados
%       (CINVESTAV) del Instituto Politecnico Nacional (IPN),
%       Unidad Merida.
% Fecha de elaboracion: 2010.05.14
% Ultima fecha de modificacion: 2010.09.12

%% Genera archivo con los nombres de los archivos de datos de ADCP para posteriormente ser leidos y procesados.
% IMPORTANTE: Realizar este proceso una sola ocasion.
%% (Makes a file with the names of ADCP files to be readed and processed)

% num=[2,5,7]; n=0;
% fid=fopen('name_all.txt','a+');
% for k=1:3
%     if (k==1); name1=['CNK1801',num2str(num(k)),'_000000.ENX.VE.txt'];
%                name2=['CNK1801',num2str(num(k)),'_000000.ENX.NV.txt'];
%                name3=['CNK1801',num2str(num(k)),'_000000.ENX.AN.txt'];
%                name4=['CNK1801',num2str(num(k)),'_000000.ENX.BT.txt'];
%                name5=['CNK1801',num2str(num(k)),'_000000.ENX.CO.txt'];
%                name6=['CNK1801',num2str(num(k)),'_000000.ENX.EA.txt'];
%                name7=['CNK1801',num2str(num(k)),'_000000.ENX.MC.txt'];
%                name8=['CNK1801',num2str(num(k)),'_000000.ENX.PG.txt'];
%                name9=['CNK1801',num2str(num(k)),'_000000.ENX.WR.txt'];
%                  fprintf(fid,'%30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\n',name1,name2,name3,name4,name5,name6,name7,name8,name9); n=n+1;
%         end
%     if (k==2); for m=0:6;
%                name1=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.VE.txt'];
%                name2=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.NV.txt'];
%                name3=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.AN.txt'];
%                name4=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.BT.txt'];
%                name5=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.CO.txt'];
%                name6=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.EA.txt'];
%                name7=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.MC.txt'];
%                name8=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.PG.txt'];
%                name9=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.WR.txt'];
%                  fprintf(fid,'%30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\n',name1,name2,name3,name4,name5,name6,name7,name8,name9); n=n+1;
%                end
%         end
%     if (k==3); for m=0:54;
%             if m<10;  name1=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.VE.txt'];
%                       name2=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.NV.txt'];
%                       name3=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.AN.txt'];
%                       name4=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.BT.txt'];
%                       name5=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.CO.txt'];
%                       name6=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.EA.txt'];
%                       name7=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.MC.txt'];
%                       name8=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.PG.txt'];
%                       name9=['CNK1801',num2str(num(k)),'_00000',num2str(m),'.ENX.WR.txt']; end
%             if m>=10; name1=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.VE.txt'];
%                       name2=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.NV.txt'];
%                       name3=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.AN.txt'];
%                       name4=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.BT.txt'];
%                       name5=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.CO.txt'];
%                       name6=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.EA.txt'];
%                       name7=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.MC.txt'];
%                       name8=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.PG.txt'];
%                       name9=['CNK1801',num2str(num(k)),'_0000',num2str(m),'.ENX.WR.txt']; end
%                  fprintf(fid,'%30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\t %30s\\n',name1,name2,name3,name4,name5,name6,name7,name8,name9); n=n+1;
%                end
%         end
% end
% fclose(fid);
% n

%% Apertura, lectura y procesado de archivos de ADCP
%% (Open, read and process ADCP files.)
fid=fopen('name_all.txt','r');
n=63;

clock

for k=1:n
    k
    % ABRE ARCHIVOS E IMPORTA DATOS
    % (Opens files and imports data)
    name=fgetl(fid);name=textscan(name,'%30s'); name=char(name, '');
    VE=name(1,:);
    NV=name(2,:);
    AN=name(3,:);
    BT=name(4,:);
    CO=name(5,:);
    EA=name(6,:);
    MC=name(7,:);
    PG=name(8,:);
    WR=name(9,:);
    
    VE=importdata(VE,'\\t'); NV=importdata(NV,'\\t'); AN=importdata(AN,'\\t');
    BT=importdata(BT,'\\t'); CO=importdata(CO,'\\t'); EA=importdata(EA,'\\t');
    MC=importdata(MC,'\\t'); PG=importdata(PG,'\\t'); WR=importdata(WR,'\\t');
    
    % REACOMODA LAS MATRICES
    % (Reshapes matrices)
    VE=[VE(:,1:8),VE(:,10:end)];
    si=size(AN); si=si(1);
    si2=size(BT); si2=si2(1);
    if si~=si2
        BT=[BT(1:2:end,:),BT(2:2:end,:)]; BT=[BT(:,1:8),BT(:,10:19)];
    elseif si==si2
        BT=[BT(:,1:8),ones(si2,6)*NaN,BT(:,9:12)];
    end

    % CREA MATRICES
    % (Create matrices)
    si=size(VE); si=si(1);                                                          % numero de renglones existentes en la matriz 'A'
    u=ones(si,40)*NaN;
    v=u; w=u; err=u; mag=u; dir=u;

    % ASIGNA LOS PARAMETROS MEDIDOS POR EL ADCP
    % (Assigns measured parameters by ADCP)

    % Velocidad ADCP
    si=size(VE); si=si(2);                                                          % numero de columnas existentes en la matriz del archivo abierto
    %celdas=si-8; celdas=ceil(celdas/6)                                             % el valor del sustraendo depende del numero de parametros que no corresponden a celdas de medicion (i.e. u,v,w,dir,etc.)
    celdas=40;
    ui=8+celdas; vi=ui+celdas; wi=vi+celdas; erri=wi+celdas; magi=erri+celdas; diri=magi+celdas;  % indice de columna final de cada variable
    ens=VE(:,1);                                                                    % numero de ensamble
    yy=VE(:,2); mm=VE(:,3); dd=VE(:,4); hh=VE(:,5); mn=VE(:,6); ss=VE(:,7);         % fecha de navegacion
    u(:,1:celdas)=VE(:,9:ui);
    v(:,1:celdas)=VE(:,ui+1:vi);
    w(:,1:celdas)=VE(:,vi+1:wi);
    err(:,1:celdas)=VE(:,wi+1:erri);
    mag(:,1:celdas)=VE(:,erri+1:magi);
                   jj=size(VE(:,magi+1:end)); jj=jj(2);
    dir(:,1:jj)=VE(:,magi+1:end);


    t=datenum(yy,mm,dd,hh,mn,ss);
    
    % Velocidad de Navegacion
    nve=NV(:,9);
    nvn=NV(:,10);
    nvm=NV(:,11);
    nvd=NV(:,12);
    flat=NV(:,13);
    flon=NV(:,14);
    llat=NV(:,15);
    llon=NV(:,16);

    % Parametros Auxiliares
    pit=AN(:,9);
    rol=AN(:,10);
    hea=AN(:,11);
    tem=AN(:,12);
    dep=AN(:,13);
    ori=AN(:,14);
    bit=AN(:,15);
    bat=AN(:,16);
    
    % Rastreo de Fondo (Bottom Track - 'BT')
    bte=BT(:,9);
    btn=BT(:,10);
    btv=BT(:,11);
    bter=BT(:,12);
    btm=BT(:,13);
    btd=BT(:,14);
    bd1=BT(:,15);
    bd2=BT(:,16);
    bd3=BT(:,17);
    bd4=BT(:,18);
    
    % Correlacion (Beams)
    c1=CO(:,9:48);
    c2=CO(:,49:88);
    c3=CO(:,89:128);
    c4=CO(:,129:168);
    cm=CO(:,169:208);
    
    % Amplitud del Eco
    e1=EA(:,9:48);
    e2=EA(:,49:88);
    e3=EA(:,89:128);
    e4=EA(:,129:168);
    em=EA(:,169:208);
    
    % MicroCAT
%     mc=MC(:,9);
    
    % Porcentaje de Utilidad ('Percent Good')
    pg1=PG(:,9:48);
    pg2=PG(:,49:88);
    pg3=PG(:,89:128);
    pg4=PG(:,129:168);
    
    % Masa de Agua ('Water Mass')
%     we=WM(:,);
%     wn=WM(:,);
%     wv=WM(:,);
%     we=WM(:,);
%     wm=WM(:,);
%     wd=WM(:,);
       
    % WinRiver

    % NOMBRES DE ARCHIVOS PARA LOS PARAMETROS
    % (File names for parameters)
    % Velocidad ADCP
    fid1=fopen('ens.dat','a');
    fid2=fopen('t.dat','a');
    fid3=fopen('u_a.dat','a');
    fid4=fopen('v_a.dat','a');
    fid5=fopen('w_a.dat','a');
    fid6=fopen('err_a.dat','a');
    fid7=fopen('mag_a.dat','a');
    fid8=fopen('dir_a.dat','a');
    % Navegacion
    fid9=fopen('u_b.dat','a');
    fid10=fopen('v_b.dat','a');
    fid11=fopen('mag_b.dat','a');
    fid12=fopen('dir_b.dat','a');
    fid13=fopen('flat.dat','a');
    fid14=fopen('flon.dat','a');
    fid15=fopen('llat.dat','a');
    fid16=fopen('llon.dat','a');
    % Auxiliares
    fid17=fopen('pit.dat','a');
    fid18=fopen('rol.dat','a');
    fid19=fopen('hea.dat','a');
    fid20=fopen('tem.dat','a');
    fid21=fopen('dep.dat','a');
    fid22=fopen('ori.dat','a');
    fid23=fopen('bit.dat','a');
    fid24=fopen('bat.dat','a');
    % Rastreo de Fondo
    fid25=fopen('bte.dat','a');
    fid26=fopen('btn.dat','a');
    fid27=fopen('btv.dat','a');
    fid28=fopen('bter.dat','a');
    fid29=fopen('btm.dat','a');
    fid30=fopen('btd.dat','a');
    fid31=fopen('bd1.dat','a');
    fid32=fopen('bd2.dat','a');
    fid33=fopen('bd3.dat','a');
    fid34=fopen('bd4.dat','a');
    % Correlacion
    fid35=fopen('c1.dat','a');
    fid36=fopen('c2.dat','a');
    fid37=fopen('c3.dat','a');
    fid38=fopen('c4.dat','a');
    fid39=fopen('cm.dat','a');
    % Amplitud del Eco
    fid40=fopen('e1.dat','a');
    fid41=fopen('e2.dat','a');
    fid42=fopen('e3.dat','a');
    fid43=fopen('e4.dat','a');
    fid44=fopen('em.dat','a');
    % Porcentaje de Utilidad
    fid45=fopen('pg1.dat','a');
    fid46=fopen('pg2.dat','a');
    fid47=fopen('pg3.dat','a');
    fid48=fopen('pg4.dat','a');
    
    si=length(t);
    for j=1:si
        fprintf(fid1,'%u\\n',ens(j,:));
        fprintf(fid2,'%f\\n',t(j,:));
        % Velocidad ADCP
        fprintf(fid3,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\\n',u(j,:));
        fprintf(fid4,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\\n',v(j,:));
        fprintf(fid5,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\\n',w(j,:));
        fprintf(fid6,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\\n',err(j,:));
        fprintf(fid7,'%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\\n',mag(j,:));
        fprintf(fid8,'%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\\n',dir(j,:));
        % Navegacion
        fprintf(fid9,'%d\\n',nve(j,:));
        fprintf(fid10,'%d\\n',nvn(j,:));
        fprintf(fid11,'%u\\n',nvm(j,:));
        fprintf(fid12,'%f\\n',nvd(j,:));
        fprintf(fid13,'%f\\n',flat(j,:));
        fprintf(fid14,'%f\\n',flon(j,:));
        fprintf(fid15,'%f\\n',llat(j,:));
        fprintf(fid16,'%f\\n',llon(j,:));
        % Auxiliares
        fprintf(fid17,'%f\\n',pit(j,:));
        fprintf(fid18,'%f\\n',rol(j,:));
        fprintf(fid19,'%f\\n',hea(j,:));
        fprintf(fid20,'%f\\n',tem(j,:));
        fprintf(fid21,'%f\\n',dep(j,:));
        fprintf(fid22,'%f\\n',ori(j,:));
        fprintf(fid23,'%f\\n',bit(j,:));
        fprintf(fid24,'%f\\n',bat(j,:));
        % Rastreo de Fondo
        fprintf(fid25,'%d\\n',bte(j,:));
        fprintf(fid26,'%d\\n',btn(j,:));
        fprintf(fid27,'%d\\n',btv(j,:));
        fprintf(fid28,'%d\\n',bter(j,:));
        fprintf(fid29,'%u\\n',btm(j,:));
        fprintf(fid30,'%f\\n',btd(j,:));
        fprintf(fid31,'%u\\n',bd1(j,:));
        fprintf(fid32,'%u\\n',bd2(j,:));
        fprintf(fid33,'%u\\n',bd3(j,:));
        fprintf(fid34,'%u\\n',bd4(j,:));
        % Correlacion
        fprintf(fid35,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',c1(j,:));
        fprintf(fid36,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',c2(j,:));
        fprintf(fid37,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',c3(j,:));
        fprintf(fid38,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',c4(j,:));
        fprintf(fid39,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',cm(j,:));
        % Amplitud del Eco
        fprintf(fid40,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',e1(j,:));
        fprintf(fid41,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',e2(j,:));
        fprintf(fid42,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',e3(j,:));
        fprintf(fid43,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',e4(j,:));
        fprintf(fid44,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',em(j,:));
        % Porcentaje de Utilidad
        fprintf(fid45,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',pg1(j,:));
        fprintf(fid46,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',pg2(j,:));
        fprintf(fid47,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',pg3(j,:));
        fprintf(fid48,'%u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\\n',pg4(j,:));
    end
    
    fclose(fid1);fclose(fid2);fclose(fid3);fclose(fid4);fclose(fid5);fclose(fid6);fclose(fid7);fclose(fid8);
    fclose(fid9);fclose(fid10);fclose(fid11);fclose(fid12);fclose(fid13);fclose(fid14);fclose(fid15);fclose(fid16);
    fclose(fid17);fclose(fid18);fclose(fid19);fclose(fid20);fclose(fid21);fclose(fid22);fclose(fid23);fclose(fid24);
    fclose(fid25);fclose(fid26);fclose(fid27);fclose(fid28);fclose(fid29);fclose(fid30);fclose(fid31);fclose(fid32);fclose(fid33);fclose(fid34);
    fclose(fid35);fclose(fid36);fclose(fid37);fclose(fid38);fclose(fid39);
    fclose(fid40);fclose(fid41);fclose(fid42);fclose(fid43);fclose(fid44);
    fclose(fid45);fclose(fid46);fclose(fid47);fclose(fid48);
    
end
clock
fclose('all');

