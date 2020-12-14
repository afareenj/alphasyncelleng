%CELL ENGINEERING FINAL PROJECT
%% Generate Simulated Dataset
axonweights = [0.1,0.2,0.3,0.2,0.2;0,0.1,0.2,0,0;0.3,0.5,0.6,0,0;0.01,0,0,0,0.5;0.2,0,0,0.2,0];
% axonweights = [0.2,0.2,0.2,0.2,0.2;0.2,0.2,0.2,0,0;0.2,0.2,0.2,0,0;0.2,0,0,0,0.5;0.2,0,0,0.2,0];

timepts = 20;
degradationexp = [-0.1,-0.1,-0.1,-0.2,-0.2];
nodeasyn = zeros(5,timepts);
injection = 1; %injected concentration of alpha synuclein
nodeasyn(5,2) = injection; %row 5 represents enteric neurons, 4 = nodose neurons, 1 = SNpc, 2 = hippocampus, 3 = striatal
% nodeasyn(1,2) = injection;
for i = 3:timepts
    nodeasyn(5,i) = nodeasyn(5,i-1)*exp(degradationexp(5))-axonweights(4,5)*nodeasyn(5,i-1)+axonweights(5,4)*nodeasyn(4,i-1);
    nodeasyn(4,i) = nodeasyn(4,i-1)*exp(degradationexp(4))-axonweights(5,4)*nodeasyn(4,i-1)+axonweights(4,5)*nodeasyn(5,i-1)-axonweights(1,4)*nodeasyn(4,i-1)+axonweights(4,1)*nodeasyn(1,i-1);
    nodeasyn(1,i) = nodeasyn(1,i-1)*exp(degradationexp(1))-axonweights(2,1)*nodeasyn(1,i-1)-axonweights(3,1)*nodeasyn(1,i-1)+axonweights(1,2)*nodeasyn(2,i-1)+axonweights(1,3)*nodeasyn(3,i-1)+axonweights(1,4)*nodeasyn(4,i-1)-axonweights(4,1)*nodeasyn(1,i-1);
    nodeasyn(2,i) = axonweights(2,1)*nodeasyn(1,i-1)+axonweights(2,3)*nodeasyn(3,i-1)+nodeasyn(2,i-1)*exp(degradationexp(2))-axonweights(3,2)*nodeasyn(2,i-1)-axonweights(1,2)*nodeasyn(2,i-1);
    nodeasyn(3,i) = axonweights(3,1)*nodeasyn(1,i-1)+axonweights(3,2)*nodeasyn(2,i-1)+nodeasyn(3,i-1)*exp(degradationexp(3))-axonweights(1,3)*nodeasyn(3,i-1)-axonweights(2,3)*nodeasyn(3,i-1);
end
plot(nodeasyn(1,:))
hold on
plot(nodeasyn(2,:))
plot(nodeasyn(3,:))
plot(nodeasyn(4,:))
plot(nodeasyn(5,:))
title('Simulated Concentration of Alpha-Synuclein')
ylabel('Concentration of Alpha-Synuclein (ug/mL)')
xlabel('Time (days)')
legend('SNpc','Hippocampus','Striatal','Nodose','Enteric')

%% Data Fitting: Degradation Rate Time Constant
degradrates = linspace(-1,0,10); %100 points between 0 and 1
% correlations = zeros(length(degradrates));
axonweights = [0.1,0.2,0.3,0.2,0.2;0,0.1,0.2,0,0;0.3,0.5,0.6,0,0;0.01,0,0,0,0.5;0.2,0,0,0.2,0];
timepts = 20;
injection = 200; %injected concentration of alpha synuclein
maxcorr = 0;
maxcorrind = zeros(1,5);
for j = 1:length(degradrates)
for k = 1:length(degradrates)
    degradationsim = [degradrates(j) degradrates(j) degradrates(j) degradrates(k) degradrates(k)];
    nodeasim = zeros(5,timepts);
    nodeasim(5,2) = injection; %row 5 represents enteric neurons, 4 = nodose neurons, 1 = SNpc, 2 = hippocampus, 3 = striatal
    for n = 3:timepts
        nodeasim(5,n) = nodeasim(5,n-1)*exp(degradationsim(5))-axonweights(4,5)*nodeasim(5,n-1)+axonweights(5,4)*nodeasim(4,n-1);
        nodeasim(4,n) = nodeasim(4,n-1)*exp(degradationsim(4))-axonweights(5,4)*nodeasim(4,n-1)+axonweights(4,5)*nodeasim(5,n-1)-axonweights(1,4)*nodeasim(4,n-1)+axonweights(4,1)*nodeasim(1,n-1);
        nodeasim(1,n) = nodeasim(1,n-1)*exp(degradationsim(1))-axonweights(2,1)*nodeasim(1,n-1)-axonweights(3,1)*nodeasim(1,n-1)+axonweights(1,2)*nodeasim(2,n-1)+axonweights(1,3)*nodeasim(3,n-1)+axonweights(1,4)*nodeasim(4,n-1)-axonweights(4,1)*nodeasim(1,n-1);
        nodeasim(2,n) = axonweights(2,1)*nodeasim(1,n-1)+axonweights(2,3)*nodeasim(3,n-1)+nodeasim(2,n-1)*exp(degradationsim(2))-axonweights(3,2)*nodeasim(2,n-1)-axonweights(1,2)*nodeasim(2,n-1);
        nodeasim(3,n) = axonweights(3,1)*nodeasim(1,n-1)+axonweights(3,2)*nodeasim(2,n-1)+nodeasim(3,n-1)*exp(degradationsim(3))-axonweights(1,3)*nodeasim(3,n-1)-axonweights(2,3)*nodeasim(3,n-1);
    end
    correl = corrcoef(nodeasim,nodeasyn);
%     correlations(i,j) = correl(1,2);
    if(correl>maxcorr)
        maxcorr = correl;
        maxcorrind = [j j j k k];
    end
end
end

% [maxval,maxind] = max(correlations);
% [maxcorr,maxcorrcol] = max(maxval);
% maxcorrrow = maxind(maxcorrcol);
maxcorrind
fprintf('Correlation: %f, Degradation Constants: %f %f %f %f %f', maxcorr, degradrates(maxcorrind(1)), degradrates(maxcorrind(2)), degradrates(maxcorrind(3)), degradrates(maxcorrind(4)), degradrates(maxcorrind(5)));

