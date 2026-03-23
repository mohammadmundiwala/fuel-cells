% Matlab Script For Curve Fit by Brute-Force Minimization%
clear all;
E_eq=1.136;
R_u=8.314;
alpha_c=1;
Fr=96485.;
T=353.15;

% a(1) I_0: Reference exchange current density A/m2
% a(2) I_lim: Limiting current density A/m2 
% a(3) R_total: total resistance ohm*m2
% a(4) I_xo: cross-over current density A/m2
 
% Fuel cell polarization model
V_mdl = @(a,I)(E_eq-R_u*T/alpha_c/Fr*log((I+a(4))/a(1))+R_u*T/(4.*Fr)*log((a(2)-(I+a(4)))/a(2))-I*a(3));
 
% Provide the experimental data 
I_exp = [  ];
V_exp = [  ];
 
hold on
scatter(I_exp,V_exp)
 
% Initial guess
a0 = [0.05; 12200.00; 2.5e-5; 30.];
 
% Brute-force minimize error function
g = @(a0) norm(V_mdl(a0,I_exp)-V_exp);
ahat = fminsearch(g,a0)
 
% Analytical performance model with parameters fit to experimental data 
V_cell = @(I) V_mdl(ahat,I); 
Irange = min(I_exp):1:max(I_exp);
plot(Irange,V_cell(Irange),'r')
hold off
