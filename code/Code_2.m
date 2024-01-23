clear; clc;
%Stage 2
%Loading data
original_array_2005 = load('C:\Users\Giannis\Desktop\Σχολή\Χρονοσειρές\Υπολογιστική Εργασία\eruption2005.dat');

%Create a timeseries from eruption 2005 for n=500
part_of_array_2005 = original_array_2005(200:(200+ 499));

%=========================================================================================================================

%Creating variables that represent the lags of each timeseries
lags_original =  0:length(original_array_2005) - 1;
lags_part =  0:length(part_of_array_2005) - 1;

%Plotting the graphs of timeseries
figure
plot(lags_original,original_array_2005);
figure
plot(lags_part,part_of_array_2005);

%=========================================================================================================================

%Computing the confidence interval for a=0.05
confidence_interval = 1.96/sqrt(length(original_array_2005));
lower_bound = -confidence_interval;
upper_bound = confidence_interval;

%Computing Autocorrelation of timeseries

figure
ac_original = autocorrelation(original_array_2005,length(original_array_2005),"Original Autocorrelation","c");
hold on
plot(ones(size(lags_original))*lower_bound, 'r--');
plot(ones(size(lags_original))*upper_bound, 'r--');
hold off;
xlabel('Lag');
ylabel('Autocorrelation');
legend('Autocorrelation','Confidence Interval');

figure
ac_part = autocorrelation(part_of_array_2005,length(part_of_array_2005),"Part of original Autocorrelation","c");
hold on
plot(ones(size(lags_part))*lower_bound, 'r--');
plot(ones(size(lags_part))*upper_bound, 'r--');
hold off;
xlabel('Lag');
ylabel('Autocorrelation');
legend('Autocorrelation','Confidence Interval');

%==========================================================================================================================

%Portmanteu test
figure
[hV_1,pV_1,QV_1,xautV_1] = portmanteauLB(ac_original,length(original_array_2005),0.05,1);
figure
[hV_2,pV_2,QV_2,xautV_2] = portmanteauLB(ac_part,length(ac_part),0.05,1);

%==========================================================================================================================

%Mutual information in order to extract tau
figure
mut_original= mutualinformation(original_array_2005, length(original_array_2005),31,"Mutual information Original","");
figure
mut_part=  mutualinformation(part_of_array_2005, length(part_of_array_2005),10,"Mutual information Part of original","");

%==========================================================================================================================

%False nearest neighbor criterion in order to choose m
figure
fnnM_original = falsenearest(original_array_2005,12,10,10,0,"Nearest Neighbor Original");
figure
fnnM_part = falsenearest(part_of_array_2005,9,10,10,0,"Nearest Neighbor Part of Original");

%=========================================================================================================================

%Forecasting local average
figure
[nrmseV_1,preM_1] = localfitnrmse(original_array_2005,12,4,10,11,0,"Local Average Original");
figure
[nrmseV_2,preM_2] = localfitnrmse(part_of_array_2005,6,3,10,11,0,"Local Average Part of original");

%Forecasting local linear
figure
[nrmseV_3,preM_3] = localfitnrmse(original_array_2005,12,4,10,11,4,"Local Linear Original");
figure
[nrmseV_4,preM_4] = localfitnrmse(part_of_array_2005,6,3,10,11,3,"Local Linear Part of Original");

%=========================================================================================================================

%Forecasting 1-step

[nrmseV_5,preM_5,phiV_1,thetaV_1] = predictARMAnrmse(original_array_2005,1,0,1,10);
lags_original_forecast = 0:10-1;
figure
plot(lags_original_forecast,original_array_2005(1:10));
hold on
plot(preM_5);
hold on
plot(preM_1(1:10,1));
hold off


figure
[nrmseV_6,preM_6,phiV_2,thetaV_2] = predictARMAnrmse(part_of_array_2005,1,0,1,10);
plot(lags_original_forecast,part_of_array_2005(1:10));
hold on
plot(preM_6);
hold on
plot(preM_2(1:10,1));


%=========================================================================================================================
[rcM_1,cM_1,rdM_1,dM_1,nuM_1] = correlationdimension(original_array_2005,12,10,"Original Timeseries",1/1000,-1.5,1.5);
[rcM_2,cM_2,rdM_2,dM_2,nuM_2] = correlationdimension(part_of_array_2005,6,10,"Part of Original",1/1000,-1.5,1.5);