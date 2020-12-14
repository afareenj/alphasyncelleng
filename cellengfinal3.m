%% CELL ENGINEERING FINAL PROJECT

%Transport based on glucose model
%parameters
kx = 20; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 180];
UCHO = 0;
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%this section is the section where bolus is administered, the non-zero part
% of the step function
ts = [180,181.3]; %duration in min
UCHO = 0; %g/min
UI = 2; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , [90 0 0 0 0]);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t1;t2];
C = [C0;Cf;Cs];

figure(1);
hold on
plot(t,C(:,1)) %plot only G(t)
ylabel('G(t) blood glucose [mg/dl]')
xlabel('t [min]')
title('BG concentration with only insulin bolus');
hold on

%Now, repeat the same for kx = 10

%parameters
kx = 10; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 180];
UCHO = 0;
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%this section is the section where bolus is administered, the non-zero part
% of the step function
ts = [180,181.3]; %duration in min
UCHO = 0; %g/min
UI = 2; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , [90 0 0 0 0]);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t1;t2];
C = [C0;Cf;Cs];

hold on
plot(t,C(:,1)) %plot only G(t)
legend('Kx = 20','Kx = 10')


%--------------------------------------------------------------
%Similarly, now for both a meal and an insulin bolus, administered at the
%same time

%parameters
kx = 20; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 180];
UCHO = 0; 
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%this section is the section where bolus is administered, the non-zero part
% of the step function
ts = [180,181.3]; %duration in min
UCHO = 20; %g/min %20 g of food
UI = 2; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , [90 0 0 0 0]);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t1;t2];
C = [C0;Cf;Cs];

figure(2);
hold on
plot(t,C(:,1)) %plot only G(t)
ylabel('G(t) blood glucose [mg/dl]')
xlabel('t [min]')
title('BG concentration with meal and insulin bolus');
hold on

%Now, repeat the same for kx = 10

%parameters
kx = 10; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 180];
UCHO = 0;
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%this section is the section where bolus is administered, the non-zero part
% of the step function
ts = [180,181.3]; %duration in min
UCHO = 20; %g/min
UI = 2; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , [90 0 0 0 0]);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t1;t2];
C = [C0;Cf;Cs];

hold on
plot(t,C(:,1)) %plot only G(t)
legend('Kx = 20','Kx = 10')


%% Meal delivered after bolus
%parameters
kx = 20; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 178.7];
UCHO = 0; 
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%The time delay before meal administered
rows = length(C0); %number of rows of Cf
Cs0 = C0(rows, :); %start where we left off
ts = [178.7 180];
UCHO = 0; 
UI = 2;
[t01,C01] = ode45(@(t01,C01) [-C01(4)+C01(2); C01(3); -2*ag*C01(3)-ag^2*C01(2)+kg*ag^2*UCHO;...
    -ax*C01(4)+ax*C01(5); -ax*C01(5)+kx*ax*UI], ts , Cs0);


%this section is the section where bolus is administered, the non-zero part
% of the step function
rows = length(C01); %number of rows of Cf
Cs0 = C01(rows, :); %start where we left off
ts = [180,181.3]; %duration in min
UCHO = 20; %g/min %20 g of food
UI = 0; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , Cs0);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t01;t1;t2];
C = [C0;C01;Cf;Cs];

figure(3);
hold on
plot(t,C(:,1)) %plot only G(t)
ylabel('G(t) blood glucose [mg/dl]')
xlabel('t [min]')
title('BG concentration with insulin bolus before meal');
hold on

%Now, repeat the same for kx = 10

%parameters
kx = 10; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 178.7];
UCHO = 0;
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%The time delay before meal administered
rows = length(C0); %number of rows of Cf
Cs0 = C0(rows, :); %start where we left off
ts = [178.7 180];
UCHO = 0; 
UI = 2;
[t01,C01] = ode45(@(t01,C01) [-C01(4)+C01(2); C01(3); -2*ag*C01(3)-ag^2*C01(2)+kg*ag^2*UCHO;...
    -ax*C01(4)+ax*C01(5); -ax*C01(5)+kx*ax*UI], ts , Cs0);


%this section is the section where bolus is administered, the non-zero part
% of the step function
rows = length(C01); %number of rows of Cf
Cs0 = C01(rows, :); %start where we left off
ts = [180,181.3]; %duration in min
UCHO = 20; %g/min
UI = 0; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , Cs0);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t01;t1;t2];
C = [C0;C01;Cf;Cs];

hold on
plot(t,C(:,1)) %plot only G(t)
legend('Kx = 20','Kx = 10')

%% Insulin After Meal
%parameters
kx = 20; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 178.7];
UCHO = 0; 
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%The time delay before meal administered
rows = length(C0); %number of rows of Cf
Cs0 = C0(rows, :); %start where we left off
ts = [178.7 180];
UCHO = 20; 
UI = 0;
[t01,C01] = ode45(@(t01,C01) [-C01(4)+C01(2); C01(3); -2*ag*C01(3)-ag^2*C01(2)+kg*ag^2*UCHO;...
    -ax*C01(4)+ax*C01(5); -ax*C01(5)+kx*ax*UI], ts , Cs0);


%this section is the section where bolus is administered, the non-zero part
% of the step function
rows = length(C01); %number of rows of Cf
Cs0 = C01(rows, :); %start where we left off
ts = [180,181.3]; %duration in min
UCHO = 0; %g/min %20 g of food
UI = 2; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , Cs0);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t01;t1;t2];
C = [C0;C01;Cf;Cs];

figure(4);
hold on
plot(t,C(:,1)) %plot only G(t)
ylabel('G(t) blood glucose [mg/dl]')
xlabel('t [min]')
title('BG concentration with insulin bolus after meal');
hold on

%Now, repeat the same for kx = 10

%parameters
kx = 10; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 178.7];
UCHO = 0;
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%The time delay before meal administered
rows = length(C0); %number of rows of Cf
Cs0 = C0(rows, :); %start where we left off
ts = [178.7 180];
UCHO = 20; 
UI = 0;
[t01,C01] = ode45(@(t01,C01) [-C01(4)+C01(2); C01(3); -2*ag*C01(3)-ag^2*C01(2)+kg*ag^2*UCHO;...
    -ax*C01(4)+ax*C01(5); -ax*C01(5)+kx*ax*UI], ts , Cs0);


%this section is the section where bolus is administered, the non-zero part
% of the step function
rows = length(C01); %number of rows of Cf
Cs0 = C01(rows, :); %start where we left off
ts = [180,181.3]; %duration in min
UCHO = 0; %g/min
UI = 2; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , Cs0);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t01;t1;t2];
C = [C0;C01;Cf;Cs];

hold on
plot(t,C(:,1)) %plot only G(t)
legend('Kx = 20','Kx = 10')

%% Meal only
%parameters
kx = 20; %/U
ax = 0.04; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 180];
UCHO = 0;
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%this section is the section where bolus is administered, the non-zero part
% of the step function
ts = [180,181.3]; %duration in min
UCHO = 0; %g/min
UI = 2; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , [90 0 0 0 0]);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t1;t2];
C = [C0;Cf;Cs];

figure(5);
hold on
plot(t,C(:,1)) %plot only G(t)
ylabel('G(t) blood glucose [mg/dl]')
xlabel('t [min]')
title('BG concentration with only insulin');
hold on

%Now, repeat the same for kx = 10

%parameters
kx = 20; %/U
ax = 0.4; %/min
ag = 0.03; %/min
kgkx = 0.1; %given to us in Figure 4 caption
kg=kgkx*kx; %mg/(dl*g)


%g(t)--blood glucose initial condition: 90
%ug(t)--food glucose absorption initial condition: 0
%u.g(t)--initial condition: 0
%x(t)--insulin release into blood initial condition: 0
%x1(t)--first stage insulin production initial condition: 0


%C is matrix of all state variables.
%C(1) = G(t); C(2)=UG(t); C(3)=UGdot(t); C(4)=X(t); C(5)=X1(t)
%Cf is the C matrix of the first section

%It is difficult to model a delta function numerically
%An easy approximation is to instead model the input as constant over a
%finite interval

%The time delay before any boluses are administered
ts = [0 180];
UCHO = 0;
UI = 0;
[t0,C0] = ode45(@(t0,C0) [-C0(4)+C0(2); C0(3); -2*ag*C0(3)-ag^2*C0(2)+kg*ag^2*UCHO;...
    -ax*C0(4)+ax*C0(5); -ax*C0(5)+kx*ax*UI], ts , [90 0 0 0 0]);

%this section is the section where bolus is administered, the non-zero part
% of the step function
ts = [180,181.3]; %duration in min
UCHO = 0; %g/min
UI = 2; %U/min

[t1,Cf] = ode45(@(t1,Cf) [-Cf(4)+Cf(2); Cf(3); -2*ag*Cf(3)-ag^2*Cf(2)+kg*ag^2*UCHO;...
    -ax*Cf(4)+ax*Cf(5); -ax*Cf(5)+kx*ax*UI], ts , [90 0 0 0 0]);


%The input bolus time period is over, so now the input is 0
%Cs is the C matrix for the second section
rows = length(Cf); %number of rows of Cf
Cs0 = Cf(rows, :); %start where we left off
ts = [181.3,718.7]; % for a total graph duration of 15 h to match Fig. 4
UCHO = 0;
UI = 0;
[t2,Cs] = ode45(@(t,Cs) [-Cs(4)+Cs(2); Cs(3); -2*ag*Cs(3)-ag^2*Cs(2)+kg*ag^2*UCHO;...
    -ax*Cs(4)+ax*Cs(5); -ax*Cs(5)+kx*ax*UI], ts , Cs0);


%concatenate results
t = [t0;t1;t2];
C = [C0;Cf;Cs];

hold on
plot(t,C(:,1)) %plot only G(t)
legend('ax = 0.04','ax = 0.4')