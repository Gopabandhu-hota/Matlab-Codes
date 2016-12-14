% This is for non-ideal load with all series elements
RL = 1000;
RS = 50;
f = 10^5;
W = 2*pi*f;
V = 1;
F = 0:10:2*10^5;
w = F*2*pi;
L = RL/(10*W);  % inductance of non-ideal load
C = 1/(W*W*L);  % capacitance of non-ideal load which is in resonance with inducatnce
C_LC=sqrt((RL-RS)/RS)/(W*RL);  %value of C for which res freq occurs at 100KHZ for LC Network(low pass)
L_LC=sqrt((RL-RS)*RS)/W;        %value of L for which res freq occurs at 100KHZ for LC Network(low pass)
L_CL=(RL/W)*sqrt(RS/(RL-RS));   %value of L for which res freq occurs at 100KHZ for CL Network(high pass)
C_CL = (W^2*L_CL^2+RL^2)/(W^2*L_CL*RL^2); %value of C for which res freq occurs at 100KHZ for CL Network(high pass)
Pmax = V^2/(4*RS);
Power = zeros(2,size(w,2));%1st column for calculating Power of LC  low pass Network 
                            %2nd column for calculating Power of CL high pass Network 

for k = 1:size(w,2)
    XL = 1i*w(1,k)*L;
    XC = -1i/(w(1,k)*C);
    Z = RL + (XL+XC);
    XC_LC = -1i/(w(1,k)*C_LC);
    XL_LC = 1i*w(1,k)*L_LC;
    Znet_LC = XC_LC*Z/(Z+XC_LC);
    XC_CL = -1i/(w(1,k)*C_CL);
    XL_CL = 1i*w(1,k)*L_CL;
    Znet_CL = XL_CL*Z/(Z+XL_CL);
   Power(1,k) = abs(V*XC_LC/((RS+XL_LC+Znet_LC)*(XC_LC+Z)))^2*RL;   %Power of LC  low pass Network 
   Power(2,k)= abs(V*XL_CL/((RS+XC_CL+Znet_CL)*(XL_CL+Z)))^2*RL;    %CL high pass Network 
end

plot(F, Power(1,:), 'Color', [0, 1.0, 0.0], 'LineStyle', '-')
hold on;
plot(F, Power(2,:), 'Color', [1, 0, 0], 'LineStyle', '-')
legend('LC Network','CL Network')

title('Power variation of non-ideal series load with frequency for both LC and CL network');
  %calculaton of bandwidth
  BW = zeros(1,2);
for k = 1:2
    for m = 1:size(w,2)
        if (Power(k,m)-(P_max/2))<0.0001
            if(w(1,m)<Wo)
                Diff(1,1) = w(1,m);
            end
            if(w(1,m)>Wo)
                Diff(1,2)=w(1,m);
            end
        end
    end
    BW(1,k) = Diff(1,2) - Diff(1,1); 
end
Bandwidth_LC = BW(1,1);
Bandwidth_CL = BW(1,2);
  
    
    