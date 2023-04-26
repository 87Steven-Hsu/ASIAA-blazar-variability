% RRY091 Galaxies and observational cosmology
% 'Angular-diameter distance versus redshift'
% Weihua Wang 2014-03-25

close all;clear;clc;

c = 3e8;             % speed of the light
Ho = 72;             % Hubble const  kms^-1Mpc^-1
w = -1;              % w is the equation-of-state parameter
n = 3*(1+w);
z = 0:0.1:10;        % redshift

% For a flat universe (k=0)
Omega0 = 0;          % Energy density of the matter at the current time
OmegaX0 = 1;         % Energy density of the dark energy at the current time

f = @(x) 1./sqrt((Omega0*(1+x).^3) + OmegaX0*(1+x).^n); 
Da0 = zeros(size(z));
for k=1:length(z)
    Da0(k) = (c/Ho)./(1+z(k)).*integral(f,0,z(k)); %eq. 1.45
end
plot(z,Ho*Da0/c,'c','LineWidth',2);
ylim([0 1]);
xlabel('\bf redshift z');
ylabel('\bf [c/H]^{-1} D_{A}(z)');
title('\bf Angular-diameter distance versus redshift');
grid on

hold on

Omega0 = 0.3;        % Energy density of the matter at the current time 
OmegaX0 = 0.7;       % Energy density of the dark energy at the current time
f = @(x) 1./sqrt((Omega0*(1+x).^3) + OmegaX0*(1+x).^n);
Da1 = zeros(size(z));
for k=1:length(z)
    Da1(k) = (c/Ho)./(1+z(k)).*integral(f,0,z(k));
end
plot(z,Ho*Da1/c,'g','LineWidth',2);

clear w;
w = -0.9;             
n = 3*(1+w);
f = @(x) 1./sqrt((Omega0*(1+x).^3) + OmegaX0*(1+x).^n);
Da3 = zeros(size(z));
for k=1:length(z)
    Da3(k) = (c/Ho)./(1+z(k)).*integral(f,0,z(k));
end
plot(z,Ho*Da3/c,'--m');

clear w;
w = -0.8;             
n = 3*(1+w);
f = @(x) 1./sqrt((Omega0*(1+x).^3) + OmegaX0*(1+x).^n);
Da3 = zeros(size(z));
for k=1:length(z)
    Da3(k) = (c/Ho)./(1+z(k)).*integral(f,0,z(k));
end
plot(z,Ho*Da3/c,'--k');

clear w;
w = -1/3;             
n = 3*(1+w);
f = @(x) 1./sqrt((Omega0*(1+x).^3) + OmegaX0*(1+x).^n);
Da3 = zeros(size(z));
for k=1:length(z)
    Da3(k) = (c/Ho)./(1+z(k)).*integral(f,0,z(k));
end
plot(z,Ho*Da3/c,'--r');

clear w;
w = -1;             
n = 3*(1+w);
Omega0 = 1;        
OmegaX0 = 0; 
f = @(x) 1./sqrt((Omega0*(1+x).^3) + OmegaX0*(1+x).^n);
Da2 = zeros(size(z));
for k=1:length(z)
    Da2(k) = (c/Ho)./(1+z(k)).*integral(f,0,z(k));
end
plot(z,Ho*Da2/c,'y','LineWidth',2);

% open Uni. Omega0 + OmegaX0 < 1
clear Omiga0; clear OmigaX0;

Omega0 = 0.3;
OmegaX0 = 0;
R0 = c/(Ho*sqrt(abs(Omega0+OmegaX0-1))); % eq. 1.40

HH = @(y)1./sqrt((Ho^2*(Omega0*(1+y).^3 + (1-Omega0-OmegaX0)*(1+y).^2 + OmegaX0*(1+y).^n))); % eq. 1.44
Da_o = zeros(size(z));
for k=1:length(z)
    %Da_o(k) = R0/(1+z(k)).*sinh(c*integral(HH,0,z(k))*180/(pi*R0));
    Da_o(k) = R0/(1+z(k)).*sinh(c*integral(HH,0,z(k))/R0); % eq. 1.47
end
plot(z,Ho*Da_o/c,'b','LineWidth',2);


clear Omiga0; clear OmigaX0;

Omega0 = 0;
OmegaX0 = 0;
R0 = c/(Ho*sqrt(abs(Omega0+OmegaX0-1))); %eq. 1.40

HH = @(y)1./sqrt((Ho^2*(Omega0*(1+y).^3 + (1-Omega0-OmegaX0)*(1+y).^2 + OmegaX0*(1+y).^n))); % eq. 1.44
Da_o = zeros(size(z));
for k=1:length(z)
    Da_o(k) = R0/(1+z(k)).*sinh(c*integral(HH,0,z(k))/R0); %eq. 1.47
end
plot(z,Ho*Da_o/c,'k','LineWidth',2);

   
% close Uni. Omega0 + OmegaX0 > 1   
clear Omiga0; clear OmigaX0;

Omega0 = 1;
OmegaX0 = 0.7;
R0 = c/(Ho*sqrt(abs(Omega0+OmegaX0-1))); % eq. 1.40

HH = @(y)1./sqrt((Ho^2*(Omega0*(1+y).^3 + (1-Omega0-OmegaX0)*(1+y).^2 + OmegaX0*(1+y).^n)));
Da_c = zeros(size(z));
for k=1:length(z)
    Da_c(k) = R0/(1+z(k)).*sin(c*integral(HH,0,z(k))/R0);
end
plot(z,Ho*Da_c/c,'r','LineWidth',2);

legend('\Omega_{0}=0,\Omega_{X0}=1,w= -1, flat',...
       '\Omega_{0}=0.3,\Omega_{X0}=0.7,w= -1, flat',...
       '\Omega_{0}=0.3,\Omega_{X0}=0.7,w= -0.9, flat',...
       '\Omega_{0}=0.3,\Omega_{X0}=0.7,w= -0.8, flat',...
       '\Omega_{0}=0.3,\Omega_{X0}=0.7,w= -1/3, flat',...
       '\Omega_{0}=1,\Omega_{X0}=0,w= -1, flat',...
       '\Omega_{0}=0.3,\Omega_{X0}=0,w= -1, open',...
       '\Omega_{0}=0,\Omega_{X0}=0,w= -1, open',...
       '\Omega_{0}=1,\Omega_{X0}=0.7,w= -1, close','location','best');