%This program was developed to determine epsilon, Pn_sat and Rp
%from measured photosynthetic CO2每response curve.
%------------------Equations used-------------
%Pn=epsilon*Pn_sat.*Ci./(epsilon.*Ci+Pn_sat)-Rp
%------------------Reference----------------
%Ye, Z., 2010. A review on modeling of responses of photosynthesis to light and CO2. 
%Chinese Journal of Plant Ecology, 34(6): 727-740.
%------------------Author-----------------------
%Author: Rangjian Qiu
%Nanjing University of Information Science & Technology
%Last update 6,Aug,2018 
%-----------------Main inputs------------------
%Ci-----intercellular CO2 concentration(micro mol/mol)
%Pn---------Photosynthesis (micro mol/m2/s)
%-----------------Main outputs----------------
%epsilon--carboxylation efficiency (mol m每2 s每1);
%Pn_sat--photosynthetic capacity (micro mol m-2 s-1);
%Rp--rate of photorespiration (micro mol CO2 m每2 s每1)
%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------------Cite-------------------------
%If the program is useful, please cite
%Qiu et al, An investigation on possible effect of leaching fractions physiological responses 
%of hot pepper plants to irrigation water salinity, BMC Plant biology, xxxx, 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc
%-------------------Load data----------------
%prepared your data in excel as follows
%the data points for each curve should be the same
%1          2            3
%Ci        Pn           Treatment lable(should be numbers)
A = xlsread('0000.xlsx'); % read excel data
Ci=A(:,1);            %intercellular CO2 concentration (micro mol/mol)
Pn=A(:,2);                 % Photosynthesis (micro mol/m2/s)
label=A(:,3);              %Treatments lable should be numbers
s=[ ];                         % storage paremeter
                       
%%%%%%%%%%%----Notice!!!----%%%%%%%%%%%%%%%%%%%%%
%%-----separate each Pn-Ci curve with every j rows-------
j=9;   % factors that separate each Pn-Ci curve with every j rows
% users should modify j based on your data.

Pn_i=reshape(Pn,j,[ ]); % separate each Pn-Ci curves with every j rows
Ci_i=reshape(Ci,j,[ ]);% separate each Pn-Ci curves with every j rows
label_i = label(1:j:length(label));%treatment label with every j rows
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------main function to calculate--------
[epsilon,Pn_sat,Rp] = Pn_Ci_fit (Pn_i,Ci_i);
%------ Store optimized results in matrix s as follows
%(treatment lable, epsilon,Pn_sat,Rp)
s=[label_i epsilon Pn_sat Rp];
header={'label', 'epsilon', 'Pn_sat', 'Rp'};
s2=num2cell(s);
%Send all the results stored in s to file name 'Optimized_Parameters_Pn_Ci.xlsx' as excle file
xlswrite('Optimized_Parameters_Pn_Ci.xlsx',[header;s2],'sheet1','A1')

%-------Figure all data points and curves--------
figure (1)
clf
%-------Figure data points------
plot (Ci_i, Pn_i,'bo','MarkerFaceColor','b','linewidth',1.5)
hold on
%-------Figure curves------------------
[M,N]=size(Ci_i);
for i=1:N;
Ci_p=0:1:1800;
beta_p=[epsilon,Pn_sat,Rp];
[Pn_p(i,:)] =Qiu_Pn_Ci(beta_p(i,:),Ci_p);
plot (Ci_p, Pn_p(i,:),'-','Color',[0.07 0.6 0.26],'linewidth',3)
end
xlabel ('Ci (\mu mol mol^{-1})','fontweight','bold','fontsize',12)
ylabel ('{\it{P_n}} (\mu mol m^{-2} s^{-1})','fontweight','bold','fontsize',12')

