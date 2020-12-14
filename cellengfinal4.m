%CELL ENGINEERING FINAL PROJECT
%% Generate Simulated Dataset
axonweights = [0.1,0.2,0.3,0.2,0.2;0,0.1,0.2,0,0;0.3,0.5,0.6,0,0;0.01,0,0,0,0.5;0.2,0,0,0.2,0];
timepts = 20;
nodeasyn = zeros(5,timepts);
injection = 1; %injected concentration of alpha synuclein
nodeasyn(5,2) = injection; %row 5 represents enteric neurons, 4 = nodose neurons, 1 = SNpc, 2 = hippocampus, 3 = striatal
% nodeasyn(1,2) = injection;
x0 = [0;0;0;0;injection];
t = [1;3;6];

for i = 3:timepts
    nodeasyn(5,i) = nodeasyn(5,i-1)-axonweights(4,5)*nodeasyn(5,i-1)+axonweights(5,4)*nodeasyn(4,i-1);
    nodeasyn(4,i) = nodeasyn(4,i-1)-axonweights(5,4)*nodeasyn(4,i-1)+axonweights(4,5)*nodeasyn(5,i-1)-axonweights(1,4)*nodeasyn(4,i-1)+axonweights(4,1)*nodeasyn(1,i-1);
    nodeasyn(1,i) = nodeasyn(1,i-1)-axonweights(2,1)*nodeasyn(1,i-1)-axonweights(3,1)*nodeasyn(1,i-1)+axonweights(1,2)*nodeasyn(2,i-1)+axonweights(1,3)*nodeasyn(3,i-1)+axonweights(1,4)*nodeasyn(4,i-1)-axonweights(4,1)*nodeasyn(1,i-1);
    nodeasyn(2,i) = nodeasyn(2,i-1)+axonweights(2,1)*nodeasyn(1,i-1)+axonweights(2,3)*nodeasyn(3,i-1)-axonweights(3,2)*nodeasyn(2,i-1)-axonweights(1,2)*nodeasyn(2,i-1);
    nodeasyn(3,i) = +nodeasyn(3,i-1)+axonweights(3,1)*nodeasyn(1,i-1)+axonweights(3,2)*nodeasyn(2,i-1)-axonweights(1,3)*nodeasyn(3,i-1)-axonweights(2,3)*nodeasyn(3,i-1);
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
