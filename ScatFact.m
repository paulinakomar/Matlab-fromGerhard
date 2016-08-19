% Calculation of scattering factors using Cromer-Mann coefficients
% following
% http://www.ruppweb.org/new_comp/scattering_factors.htm

lambda=1.541;
% Ni
a=[12.838 7.292 4.444 2.380];
b=[3.878  0.257 12.176 66.342];
c=[1.034  0     0      0];

% Ti
a=[9.759 7.356 1.699 1.902];
b=[7.851 0.500 35.634 116.105];
c=[1.281  0     0      0];

% Sn
a=[19.189 19.101 4.458 2.466];
b=[5.830 0.503 26.891 83.957];
c=[4.782  0     0      0];

% Zr
a=[17.876 10.948 5.417 3.657];
b=[1.276  11.916 0.118 87.663];
c=[2.069  0     0      0];

% Hf
a=[29.144 15.173 14.759 4.300];
b=[1.833  9.600  0.275  72.029];
c=[8.582  0     0      0];

% V
a=[10.297 7.351 2.070  2.057];
b=[6.866  0.438 26.894 102.478];
c=[1.220  0     0      0];

Twotheta=30; thetar=Twotheta/180*pi/2;
f=0;
for k=1:4
   f=f+a(k)*exp(-b(k)*((sin(thetar))/lambda)^2)+c(k);
end
f
