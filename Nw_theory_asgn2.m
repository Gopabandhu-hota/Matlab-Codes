RL = 1000;
RS = 50;
V = 1;
f=10^5;
W = 2*pi*f;
F = 10^4:10:10^6;
w = 2*pi*F;
x = 200:10:900;
BW = zeros(1,size(x,2));
P = zeros(size(x,2),size(w,2));
siz=1;
for k = 1:size(x,2)
     C2 = sqrt((1000/x(1,k))-1)/(1000*W);
     L2 = 1000^2*C2/(1000^2*W^2*C2^2+1);
     C1 = sqrt((x(1,k)/50)-1)/(x(1,k)*W);
     L1 = x(1,k)^2*C1/(x(1,k)^2*W^2*C1^2+1);
    for m = 1:size(w,2)
       XC1 = -1i/(w(1,m)*C1);
       XC2 = -1i/(w(1,m)*C2);
       XL1 =  1i*(w(1,m)*L1);
       XL2 =  1i*(w(1,m)*L2);
       Z2 = ((XL1+50)*XC1/(50+XL1+XC1))+XL2;
       ZTH = XC2*Z2/(XC2+Z2);
       Z3 = XC1*(XL2-XC2)/(XC1+XC2+XL2);
       Z4 = XC1*XC2/(XC1+XC2+XL2);
       VTH = V*Z4/(50+XL1+Z3);
       P(k,m) = (abs(VTH/(ZTH+1000)))^2*1000;
    end
end
Diff = zeros(2,size(x,2));
P_max = zeros(1,size(x,2));
for k = 1:size(x,2)
    P_max(1,k) = max(P(k,5000:size(w,2)));
    format long
    for m = 2000:size(w,2)
        if P(k,m)==P_max(1,k)
            W = w(1,m);
        end
    end
    for m = 1:size(w,2)
        if (P(k,m)-(P_max(1,k)/2))<0.0001
            if(w(1,m)<W)
                Diff(1,k) = w(1,m);
            end
            if(w(1,m)>W)
                Diff(2,k)=w(1,m);
            end
        end
    end
    BW(1,k) = Diff(2,k) - Diff(1,k); 
end
plot(x,BW);
   
   

       
        
        


