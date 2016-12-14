RL = 1000;
RS = 50;
F = 10^5;
Wo = 2*pi*F;
C=sqrt((RL-RS)/RS)/(Wo*RL);  %value of C for which res freq occurs at 100KHZ for LC Network(low pass)
L=sqrt((RL-RS)*RS)/Wo;         %value of L for which res freq occurs at 100KHZ for LC Network(low pass)
C_array = C + 0.2*C*(rand(1,1000)-0.5); %C_array varies betn (+- 10% )of C
L_array = L + 0.2*L*(rand(1,1000)-0.5); %L_array varies betn (+- 10% )of L
Power = zeros(1,1000000);
for i = 1:1000
    for j =1:1000
        Power(1,((i-1)*1000)+j) = (RL)/((RL+RS-(Wo*Wo*C_array(1,i)*RL*L_array(1,j)))^2 +(Wo*L_array(1,j)+Wo*C_array(1,i)*RL*RS)^2);
    end
end

hist(Power,1000)  %plots histogram  of Power
title('Histogram for Power distribution ');
plot( xlabel('Power(W)'), ylabel('Probability'))
