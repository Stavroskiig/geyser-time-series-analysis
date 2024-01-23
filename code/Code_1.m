clear;clc;
%First Stage
%Loading Data
original_array_1989 = load('C:\Users\Giannis\Desktop\Σχολή\Χρονοσειρές\Υπολογιστική Εργασία\eruption1989.dat');
original_array_2000 = load('C:\Users\Giannis\Desktop\Σχολή\Χρονοσειρές\Υπολογιστική Εργασία\eruption2000.dat');
original_array_2011 = load('C:\Users\Giannis\Desktop\Σχολή\Χρονοσειρές\Υπολογιστική Εργασία\eruption2011.dat');



%Create a random timseries for 2000
random_index_2000 = randi(739 - 298 +1);
new_array_2000 = original_array_2000(random_index_2000:(random_index_2000+297));



%Create a random timseries for 2011
random_index_2011 = randi(3507 - 298 +1);
new_array_2011 = original_array_2011(random_index_2011:(random_index_2011+297));

%==========================================================================================================================

% 1)
%Calculate autocorrelation and confidence interval for Timeseries 1989
ac_1989 = autocorrelation(original_array_1989,30,"autocorrelaion 1989",'');
hold on

confidence_interval = 1.96/sqrt(length(original_array_1989));
lower_bound = -confidence_interval;
upper_bound = confidence_interval;

lags = 0:length(ac_1989) - 1;
plot(ones(size(lags))*lower_bound, 'r--');
plot(ones(size(lags))*upper_bound, 'r--');
hold off;
xlabel('Lag');
ylabel('Autocorrelation');
legend('Autocorrelation',"Autocorrelation Points", 'Confidence Interval');

%==========================================================================================================================

%Calculate autocorrelation and confidence interval for Timeseries 2000
figure
ac_2000 = autocorrelation(new_array_2000,30,"autocorrelaion 2000",'');
hold on

confidence_internval = 1.96/sqrt(length(new_array_2000));
lower_bound = -confidence_internval;
upper_bound = confidence_internval;

lags = 0:length(ac_2000) - 1;
plot(ones(size(lags))*lower_bound, 'r--');
plot(ones(size(lags))*upper_bound, 'r--');
hold off;
xlabel('Lag');
ylabel('Autocorrelation');
legend('Autocorrelation', "Autocorrelation Points" ,'Confidence Interval');

%==========================================================================================================================

%Calculate autocorrelation and confidence interval for Timeseries 2011
figure
ac_2011 = autocorrelation(new_array_2011,30,"autocorrelaion 2011",'');
hold on

confidence_internval = 1.96/sqrt(length(new_array_2011));
lower_bound = -confidence_internval;
upper_bound = confidence_internval;

lags = 0:length(ac_2011) - 1;
plot(ones(size(lags))*lower_bound, 'r--');
plot(ones(size(lags))*upper_bound, 'r--');
hold off;
xlabel('Lag');
ylabel('Autocorrelation');
legend('Autocorrelation',"Autocorrelation Points" ,'Confidence Interval');

%==========================================================================================================================


% 2)
figure
parcorr(original_array_1989)
[nrmseV,phiV,thetaV,SDz,aicS,fpeS,armamodel]= fitARMA(original_array_1989,1,0,3);

