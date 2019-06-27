function [epsilon,Pn_sat,Rp] = Pn_Ci_fit (Pn,Ci)

opts=statset('MaxIter',800,'TolX',1e-6);
opts.Robust='Bisquare';
[M, N]=size (Ci);

for i=1:N
    x(:,i)=Ci(:,i);
    y(:,i)=Pn(:,i);
    beta0=[0.1 20 1];  % initial parameters
[beta,resnorm]= lsqcurvefit(@Qiu_Pn_Ci,beta0,x(:,i),y(:,i), [0 0 0], [1 +inf +inf],opts);
    epsilon(i)=beta(1);
    Pn_sat(i)=beta(2);
    Rp(i)=beta(3);
      end
%----convert row to column-----
epsilon=epsilon';
Pn_sat=Pn_sat';
Rp=Rp';



