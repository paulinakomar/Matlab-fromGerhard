% Simulation der Satellitenpeaks um 200 und 400 peak
% beide Strukturfaktoren im jeweiligen Winkelbereich
Ni=28;Ti=22;Zr=40;Hf=72;Sn=50;
f1_V=18.05;   f1_Ni=23.3; f1_TiSn=17.05+42.2; f1_ZrHfSn=0.5*32.84+0.5*63.04+42.2; % für 30° in Twotheta
f2_V=13.3597; f2_Ni=17.9; f2_TiSn=12.57+33.55; f2_ZrHfSn=0.5*26.17+0.5*52.47+33.55; % für 60° Strukturfaktoren für 1. und 2. Streubereich

d_buffer=6.200/4 %   6.24; %strained value  %d_buffer=6.048;%=unstrained % 2*bulk lattice constant of Vanadium
Nrelaxation=17; % Relaxation length in atomic layers
delta=0.19/4; %delta=0; absolute value of the strain
d_a=5.91/4; % best: 5.91   Lit: 5.941  Gitterkonstante TiNiSn / 4 = echter Netzebenenabstand der Atomlagen im Realraum
d_b=6.17/4; % best: 6.17   Lit: 6.070  Gitterkonstante Zr05Hf05NiSn
d_inter=(d_a+d_b)/2;

lambda=1.541838;
twotheta1=25:0.01:35; twotheta2=50:0.01:70; twotheta=[twotheta1 twotheta2]; % Bereich um (200) und um (400)
thetar1=twotheta1/180*pi/2;thetar2=twotheta2/180*pi/2;thetar=twotheta/180*pi/2;
dq1=4*pi/lambda*sin(thetar1);dq2=4*pi/lambda*sin(thetar2);dq=4*pi/lambda*sin(thetar); % Impulsübertrag
% Impulsübertrag dq=[dq1 dq2] da in Bereich 1 andere Strukturfaktoren als
% in Bereich 2 benoetigt werden
load v11fs.dat;
tt1exp=v11fs(751:1250,1);counts1=v11fs(751:1250,2);counts1n=counts1./max(counts1);
tt2exp=v11fs(2001:3000,1);counts2=v11fs(2001:3000,2);counts2n=counts2./max(counts2);

% 22nm=36EZ TiNiSn darunter + Start mit TiNiSn
% Ab hier Aufbau des Übergitters
N_buffer=14;   % Anzahl EZ NiTiSn buffer bzw Halbe Anzahl EZ V Lagen (sollten 16 sein)
N_bilayer=0; % Anzahl Wiederholungen
N_EZ_a=13.0; % 13 TiNiSn  Anzahl der Elementarzellen; muss in aktueller Version in 1/4 Schritten gewaehlt werden!
N_EZ_b=13.0; % 13 Zr05Hf05 NiSn
N_a=N_EZ_a*4; N_b=N_EZ_b*4; % Anzahl Netzebenen Achtung > Anzahl EZ
N=(N_a+N_b)*N_bilayer + N_buffer*4;  % Letzter Term für TiNiSn Buffer
zposition=zeros(1,N);  % Ort der Netzebenen
f=zposition; % Scattering factor der Netzebenen
currentN=1; currentposition=0;
f_a=1; f_b=0; % f_a als logische Variable: Netzebene gehoert zu Typ a, f_a=1 oder Typ b f_b=0
% ermoeglicht spaeter Interpretation als interdiffusion und Prozentwerte 0<=f_a<=1 
for b=1:N_buffer*4
    f(currentN)=f_a;   % Strukturfaktor der n-ten Netzebene starte Buffer mit a
   % zposition(currentN)=currentposition+d_a;  % z-Koordinate der n-ten Netzebene am Interface
  %  zposition(currentN)=currentposition+d_buffer+delta*(currentN/(N_buffer*4))^4;
  %  % Relaxation einbauen, Potenzverhalten
     zposition(currentN)=currentposition+d_buffer+delta*exp(-currentN/Nrelaxation);  % Exponentielle Relaxation einbauen
     %dTemp2(b)=delta*exp(-currentN/Nrelaxation);  %Just saving Relaxation behavior separately
     currentposition=zposition(currentN);  % aktuelle z-Koordinate
    currentN=currentN+1;
end
for b=1:N_bilayer
    f(currentN)=f_a;   % Strukturfaktor der n-ten Netzebene starte mit a
    zposition(currentN)=currentposition+d_inter;  % z-Koordinate der n-ten Netzebene am Interface
    currentposition=zposition(currentN);  % aktuelle z-Koordinate
    currentN=currentN+1;
    if N_a >1
       for s=2:N_a
         f(currentN)=f_a;   % Strukturfaktor der n-ten Netzebene
         zposition(currentN)=currentposition+d_a;  % z-Koordinate der n-ten Netzebene
         currentposition=zposition(currentN);  % aktuelle z-Koordinate
         currentN=currentN+1;
       end % s 
    end % if
    f(currentN)=f_b;   % Strukturfaktor der n-ten Netzebene jetzt cfs
    zposition(currentN)=currentposition+d_inter;  % z-Koordinate der n-ten Netzebene am Interface
    currentposition=zposition(currentN);  % aktuelle z-Koordinate
    currentN=currentN+1;
    if N_b >1
      for c=2:N_b  % war hier falsch
        f(currentN)=f_b;   % Strukturfaktor der n-ten Netzebene
        zposition(currentN)=currentposition+d_b;  % z-Koordinate der n-ten Netzebene
        currentposition=zposition(currentN);  % aktuelle z-Koordinate
        currentN=currentN+1;
    end % c    
   end % if
end % b    
% Bis hier Aufbau des Übergitters


Ftot1=0; Ftot2=0; % Ftot = Vektor mit Streukraeften als Fkt des Impulsuebertrages=Winkel
% So startet Übergitter mit Ti (NiSn)
% for z=1:2:N
% %  Ftot=Ftot+f(z)*exp(i*dq*zposition(z)); 
%   Ftot1=Ftot1+(f(z)*f1_TiSn+(1-f(z))*f1_ZrHfSn)*exp(i*dq1*zposition(z)); % TiSn bzw. ZrHfSn Ebene
%   Ftot1=Ftot1+(f(z+1)*f1_Ni+(1-f(z+1))*f1_Ni)*exp(i*dq1*zposition(z+1)); % Ni Ebene (unterscheidung eigentlich überflüssig)
%   Ftot2=Ftot2+(f(z)*f2_TiSn+(1-f(z))*f2_ZrHfSn)*exp(i*dq2*zposition(z)); % TiSn bzw. ZrHfSn Ebene 
%   Ftot2=Ftot2+(f(z+1)*f2_Ni+(1-f(z+1))*f2_Ni)*exp(i*dq2*zposition(z+1)); % Ni Ebene 
%   % In obiger Gleichung ist dq ein Vektor!
%   % f(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
%   % gleichzeitig f(k,q) Winkelabhaengig sein
% end
% Unten obere Schleife aber nur für V Buffer
for z=1:2:N_buffer*4
%  Ftot=Ftot+f(z)*exp(i*dq*zposition(z)); 
  Ftot1=Ftot1+(f(z)*f1_V)*exp(i*dq1*zposition(z)); % V  Ebene, EZ zu groß gewählt
  Ftot1=Ftot1+(f(z+1)*f1_V)*exp(i*dq1*zposition(z+1)); % V Ebene (unterscheidung eigentlich überflüssig)
  Ftot2=Ftot2+(f(z)*f2_V)*exp(i*dq2*zposition(z)); % V Ebene 
  Ftot2=Ftot2+(f(z+1)*f2_V)*exp(i*dq2*zposition(z+1)); % V Ebene 
  % In obiger Gleichung ist dq ein Vektor!
  % f(z) ist Ortsabhaengigkeit des Strukturfaktors und kann so nicht
  % gleichzeitig f(k,q) Winkelabhaengig sein
end
Ftot=[Ftot1 Ftot2];
Intensity=(abs(Ftot)).^2;
Intensity=Intensity/max(Intensity);
Intensity1=((abs(Ftot1)).^2)/max(Intensity); Intensity2=((abs(Ftot2)).^2)/max(Intensity);
%plot(twotheta,Intensity)
%figure(1)
%semilogy(twotheta,Intensity+1e-6)

w=0.002; %war 0.12 für Übergitter
Ntwothetavalues=max(size(twotheta));
IntensityGauss=zeros(1,Ntwothetavalues);
for k=1:Ntwothetavalues  % daemlich das hier tausendmal zu berechnen
center=twotheta(k);
gauss=1/w/sqrt(pi/2)*exp(-2/w/w*(twotheta-center).^2);
IntensityGauss(k)=gauss*Intensity';
end
IntensityGauss=IntensityGauss/max(IntensityGauss);
IntensityGauss1=IntensityGauss(1:length(twotheta1));
IntensityGauss1=IntensityGauss1/max(IntensityGauss1);% 1 satz peaks getrennt normieren
IntensityGauss2=IntensityGauss(length(twotheta1)+1:Ntwothetavalues);

% Untergrundberechnung Peakposition für lambdaCu=1.541838; war 59.3°
% für Ni mit lambda=1.49A wäre Peakpos lambdaCu/sin(ThetaCu)=lambdaNi/sin(ThetaNi)
%  arcsin(1.49/1.542*sin(59.3/2/180*pi))*180/pi*2 = 57.11° sieht nicht
%  besser aus als im Peakmaxim Untergrundintensität umzuschalten 

background2=(twotheta2<59.3)*25+25;
figure(2)
semilogy(twotheta2,2000*IntensityGauss2+background2,tt2exp,counts2)
%semilogy(twotheta,Intensity,twotheta,IntensityGauss+1e-6)
%semilogy(twotheta,IntensityGauss+1e-6)
%plot(twotheta,IntensityGauss+1e-6)

figure(1)
subplot(221)
%plot(twotheta1,Intensity1,ttexp1,counts1)
plot(twotheta1,IntensityGauss1)
axis([25 35 0 1]);%axis([27.5 31.5 0 7e10])
subplot(222)
%plot(twotheta2,Intensity2,ttexp2,counts2)
plot(twotheta2,IntensityGauss2)
subplot(223)
semilogy(twotheta1,IntensityGauss1+3e-4)
subplot(224)
semilogy(twotheta2,IntensityGauss2+1e-3)