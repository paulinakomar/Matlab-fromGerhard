function [twotheta1, Intensity1, twotheta2, Intensity2, IntensityGauss1, IntensityGauss2] = sl_withInput(system, range)
% clear all, close all, clc

%% Parameters needed for the simulation of satellite peaks of 200 and 400 peaks
    % structure factors (from PowderCell) and lattice constants
    % all structure factors are real
    f_TNS_200 = 143.75;
    f_TNS_400 = 250.87;
        a_TNS = 5.94;

    f_HNS_200 = 329.38;
    f_HNS_400 = 413.93;
        a_HNS = 6.108;

    f_ZHNS_200 = 268.82;
    f_ZHNS_400 = 361.50;
        a_ZHNS = 6.1082;

    switch system
        case 1
            f_a200 = f_TNS_200;
            f_a400 = f_TNS_400;
               d_a = a_TNS;
               
            f_b200 = f_HNS_200;    
            f_b400 = f_HNS_400;
               d_b = a_HNS;
               
        case 2
            f_a200 = f_HNS_200;
            f_a400 = f_HNS_400;
               d_a = a_HNS;
               
            f_b200 = f_TNS_200;    
            f_b400 = f_TNS_400;
               d_b = a_TNS;
               
        case 3
            f_a200 = f_TNS_200;
            f_a400 = f_TNS_400;
               d_a = a_TNS;
               
            f_b200 = f_ZHNS_200;    
            f_b400 = f_ZHNS_400;
               d_b = a_ZHNS;
               
        case 4
            f_a200 = f_ZHNS_200;
            f_a400 = f_ZHNS_400;
               d_a = a_ZHNS;
               
            f_b200 = f_TNS_200;    
            f_b400 = f_TNS_400;
               d_b = a_TNS;
               
        case 5
            f_a200 = f_HNS_200;
            f_a400 = f_HNS_400;
               d_a = a_HNS;
               
            f_b200 = f_ZHNS_200;    
            f_b400 = f_ZHNS_400;
               d_b = a_ZHNS;
               
        case 6
            f_a200 = f_ZHNS_200;
            f_a400 = f_ZHNS_400;
               d_a = a_ZHNS;
               
            f_b200 = f_HNS_200;    
            f_b400 = f_HNS_400;
               d_b = a_HNS;
               
    end
    
    % average lattice constant
    d_inter = (d_a+d_b)/2;

    lambda = 1.540598;     % wavelength 
    
    % two theta range
    twotheta1 = range(1,1):range(1,2):range(1,3); % in degrees
    twotheta2 = range(2,1):range(2,2):range(2,3); % in degrees
        twotheta=[twotheta1 twotheta2]; % 200 and 400 range in degrees
        
    thetar1=twotheta1/180*pi/2; % in radians
    thetar2=twotheta2/180*pi/2; % in radians
        thetar=twotheta/180*pi/2; % 200 and 400 range in radians
    
    % momentum transfer
    dq1=4*pi/lambda*sin(thetar1);
    dq2=4*pi/lambda*sin(thetar2);
        dq=4*pi/lambda*sin(thetar);
% Impulsübertrag dq=[dq1 dq2] da in Bereich 1 andere Strukturfaktoren als
% in Bereich 2 benoetigt werden


%% Construction of the superlattice 
N_bilayer=29; % How many times the bilayer is repeated
N_EZ_a=10.0; % Number of unit cells in layer a; muss in aktueller Version in 1/4 Schritten gewaehlt werden!
N_EZ_b=10.0; % Number of unit cells in layer b
    N_a=N_EZ_a*4; % Number of planes
    N_b=N_EZ_b*4; % Anzahl Netzebenen Achtung > Anzahl EZ
        N=(N_a+N_b)*N_bilayer; % total number of planes
        
zposition=zeros(1,N);  % place of lattice planes
f=zposition; % Scattering factor for the lattice planes
    currentN=1; 
    currentposition=0;
        f_a=1; 
        f_b=0; % f_a als logische Variable: Netzebene gehoert zu Typ a, f_a=1 oder Typ b f_b=0
        
% ermoeglicht spaeter Interpretation als interdiffusion und Prozentwerte 0<=f_a<=1 
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
for z=1:N
%  Ftot=Ftot+f(z)*exp(i*dq*zposition(z)); 
  Ftot1=Ftot1+(f(z)*f_a200+(1-f(z))*f_b200)*exp(i*2*dq1*zposition(z)); % Warum zwei
  Ftot2=Ftot2+(f(z)*f_a400+(1-f(z))*f_b400)*exp(i*dq2*zposition(z)); 
  % In obiger Gleichung ist dq ein Vektor!
  % f(z) ist Ortsabhaengigkeit des Strkturfaktors und kann so nicht
  % gleichzeitig f(k,q) Winkelabhaengig sein
end

Ftot=[Ftot1 Ftot2];
    Intensity=(abs(Ftot)).^2;
    Intensity=Intensity/max(Intensity);
        Intensity1=((abs(Ftot1)).^2)/max(Intensity); 
        Intensity2=((abs(Ftot2)).^2)/max(Intensity);
%plot(twotheta,Intensity)
%figure(1)
%semilogy(twotheta,Intensity+1e-6)

%% Gauss shape of peaks
w=0.1;
Ntwothetavalues=max(size(twotheta));
IntensityGauss=zeros(1,Ntwothetavalues);

for k=1:Ntwothetavalues  % daemlich das hier tausendmal zu berechnen
    center=twotheta(k);
    gauss=1/w/sqrt(pi/2)*exp(-2/w/w*(twotheta-center).^2);
    IntensityGauss(k)=gauss*Intensity';
end
IntensityGauss=IntensityGauss/max(IntensityGauss);
    IntensityGauss1=IntensityGauss(1:length(twotheta1));
    IntensityGauss2=IntensityGauss(length(twotheta1)+1:Ntwothetavalues);

%figure(2)
%semilogy(twotheta,Intensity,twotheta,IntensityGauss+1e-6)
%semilogy(twotheta,IntensityGauss+1e-6)
%plot(twotheta,IntensityGauss+1e-6)

% figure()
%     subplot(221)
%         plot(twotheta1,Intensity1)
%     subplot(222)
%         plot(twotheta2,Intensity2)
%     subplot(223)
%         semilogy(twotheta1,IntensityGauss1+1e-6)
%     subplot(224)
%         semilogy(twotheta2,IntensityGauss2+1e-6)