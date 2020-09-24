% Test Point Calculations
% Kerianne Hobbs
% 19 June 2020
clear all;
close all;
clc;

thetas = [pi/2;pi;-3*pi/4; 3*pi/4;pi/4;
    -pi/2;-3*pi/8;-pi/4;0]; %[rad]
Vints= [1050;900;150;600;300;750;1145;450;60]; %[ft]
rhos = [43736,43736, 10000, 43736, 10000, 43736, 87472, 43736, 43736]; % [ft]
T = 100; %[s]

psi = zeros(9,1);
phis = zeros(9,1);
Vowns = zeros(9,1);
for i = 1:1:9
    %if(thetas(i)>0&& thetas(i) <pi/2)
        %psi(i) = -imag(asin(Vints(i)*T/(rhos(i)*sin(thetas(i)))))*180/pi;
    %end
    
    
    
   
    if(thetas(i)== pi||thetas(i) == -pi)
        psi(i) = 0;
        Vowns(i) = (T*Vints(i)-rhos(i))/T;
        phis(i) = 0;
    end
    
   
    if(thetas(i)<0 && thetas(i) >-pi)
        psi(i) = asin(rhos(i)/(Vints(i)*T)*sin(abs(thetas(i))));
        phis(i) = pi - abs(thetas(i)) - abs(psi(i));
        Vowns(i) = Vints(i)*sin(phis(i))/sin(abs(thetas(i)));
    end
    
    
    

    if(thetas(i)>0 && thetas(i)<pi)
        psi(i) =-asin(rhos(i)/(Vints(i)*T)*sin(abs(thetas(i))));
        phis(i) = pi - abs(thetas(i)) - abs(psi(i));
        Vowns(i) = Vints(i)*sin(phis(i))/sin(abs(thetas(i)));
    end
    


    
    % Test Case 9
    if(thetas(i)==0)
        psi(i) = 0;
        Vowns(i) = (T*Vints(i)+rhos(i))/T;
    end
    
    

    %psi(i) = -imag(asin(Vints(i)*T/(rhos(i)*sin(thetas(i)))))*180/pi;
    
end
phisd = phis*180/pi
Vowns
psi
psid =psi*180/pi

