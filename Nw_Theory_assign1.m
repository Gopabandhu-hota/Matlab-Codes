RL = 10000;    %value of load resistance
RS = 50;        %value of source resistance
V = 1;          %source voltage
f=10^5;          %resonant frequency
W = 2*pi*f;
F = 0:10:2*10^5; % frequency varies betn 0 to 2*res freq
w = 2*pi*F;
C=sqrt((RL-RS)/RS)/(W*RL);  %value of C for which res freq occurs at 100KHZ for LC Network(low pass)
L=sqrt((RL-RS)*RS)/W;       %value of L for which res freq occurs at 100KHZ for LC Network (low pass)
L1=(RL/W)*sqrt(RS/(RL-RS)); %value of L for which res freq occurs at 100KHZ for CL Network(high pass)
C1 = (W^2*L^2+RL^2)/(W^2*L*RL^2); %value of  for which res freq occurs at 100KHZ for CL Network(high pass)
Power_LC = zeros(1,size(w,2));    %Power of LC Network
Power1_CL = zeros(1,size(w,2));    %power of CL network
Diff = zeros(1,2);
%below code calculates power for both LC and CL Network
for m = 1:size(w,2)
    XC = (-1i/(w(1,m)*C));
    XL =  1i*w(1,m)*L;
    Z = XC*RL/(XC+RL);
    Z1 = XL*RL/(XL+RL);
    format long;
    Power_LC(1,m)= ((abs(Z/(RS+XL+Z)))^2)/RL;
    Power1_CL(1,m)= ((abs(Z1/(RS+XC+Z1)))^2)/RL;
end
title('Power variation with frequency ');
plot(F,Power_LC), xlabel('frequency(Hz)'), ylabel('Power(W)')
hold on;
plot(F,Power1_CL)
hold on;
legend('LC_highpass','CL_lowpass')
%find max power for both LC and CL network
    P_max = max(Power_LC(1,:));
    P_max1 = max(Power1_CL(1,:));
 %find bandwidth of LC network
    for m = 1:size(w,2)
        if (abs(Power_LC(1,m)-(P_max/2)))<0.00005
            if(w(1,m)<W)
                Diff(1,1) = w(1,m);
            end
            if(w(1,m)>W)
                Diff(1,2)=w(1,m);
            end
        end
    end
    BW = Diff(1,2) - Diff(1,1); 
    disp(BW)
    
    %find bandwidth for CL Network
     for m = 1:size(w,2)
        if (abs(Power1_CL(1,m)-(P_max/2)))<0.00005
            if(w(1,m)<W)
                Diff(1,1) = w(1,m);
            end
            if(w(1,m)>W)
                Diff(1,2)=w(1,m);
            end
        end
    end
    BW1= Diff(1,2) - Diff(1,1); 
    
  

        

