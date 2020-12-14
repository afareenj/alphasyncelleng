%CELL ENGINEERING FINAL PROJECT
clc;
close all;
% Cellular Level Transport Comparison
data = [95.09808,86.7675,88.86411;87.01579,79.31396,70.31438;66.21803,59.95992,31.05295]
figure
scatter([5;1;1/3],data(:,1))
f = @(x,xdata)100*xdata./(x(2)+xdata);
x0 = [1 1];
[x,resnorm,~,exitflag,output] = lsqcurvefit(f,x0,[5;1;1/3],data(:,1));
xtest = 0:0.1:5;
ytest = f(x,xtest);
hold on;
plot(xtest,ytest)
ylabel('Percentage of Cells with Alpha-Synuclein')
xlabel('Concentration of Injected Alpha-Synuclein (ug/ml)')
title('Fitting Preliminary Aim 1 Data for Day 1 Alpha-Synuclein Uptake')
interp1(ytest,xtest,2,'spline')
keyboard;
testdata1 = data(1,:); 
testdata2 = data(2,:);%testing data for 1 ug/ml injection concentration
testdata3 = data(3,:);
diff(testdata1)
% Peclet Number
lengthtransport = 200; %length of campenot chamber
v = mean(diff(testdata));
l = 2; %approximated diameter of axon
d = 5.2;
pe = v*l/d;
if(pe<1)
    fprintf('Diffusion dominates: Peclets number %f\n', pe);
else
    fprintf('Advection dominates: Peclets number %f\n', pe);
end

%% Continuous vs. Discrete Quanta
stddev = 0.07;
mu = [0.3 0.6 0.9];
ntrials = 80;
z = [repmat(mu(1),ntrials,1);repmat(mu(2),ntrials/2,1);repmat(mu(3),ntrials/4,1)]+randn(ntrials+ntrials/2+ntrials/4,1)*stddev;
z = z(z<1); %Normalized Fluorescence Intensity Values
figure
histogram(z,'BinWidth',0.1)
title('Prediction of Data Supporting Discrete Quanta Hypothesis')
xlabel('Normalized Fluorescence Intensity')
ylabel('Count')
figure

% Evaluate data
frac = [(25+randn(ntrials,1)*5);(50+randn(ntrials/2,1)*5);(60+randn(ntrials/4,1)*5)]; %percentage of cells with fluorescent tag
frac = frac(1:length(z));
n0 = 1-frac./100; %value for n0/N, fraction of cells without a-syn
expm = -log(n0);
scatter(z,expm);
b = fitlm(z,expm)
coeffs = table2array(b.Coefficients(:,1));
regline = coeffs(2)*(0:0.5:max(z)+0.5)+coeffs(1);
hold on;
plot(0:0.5:max(z)+0.5,regline);
ylabel('-ln(n_0/N)')
xlabel('Mean Normalized Fluorescence Intensity');
title('Predicted Results for Poisson Distribution Experimental vs. Predicted m')