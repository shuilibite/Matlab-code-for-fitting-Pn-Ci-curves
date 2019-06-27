function [Pn] =Qiu_Pn_Ci(beta,Ci)

epsilon=beta(1);
Pn_sat=beta(2);
Rp=beta(3);
Pn=epsilon*Pn_sat.*Ci./(epsilon.*Ci+Pn_sat)-Rp;
end