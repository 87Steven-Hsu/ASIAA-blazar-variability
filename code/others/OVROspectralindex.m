%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a code to fit OVRO source specral index (VLA & NVSS)
% a code to do correlation test between spectral index and variability
% timescale and SF amplitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% spectral index fitting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Read data
data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/OVRO spectral index data/OVRO Xmatch NVSS and VLASS_csv.csv'); 
fid = fopen(data);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %s %f %f %f %f %f','delimiter',','); 
fclose(fid); 

name = string( Table{1} );  
NVSS_dis = Table{2}; 
NVSS_flux = Table{3};   %% 1.4 GHz = 1.4E9 Hz [flux unit: Jy]
NVSS_flux_err = Table{4}; 
VLASS_dis = Table{6};   %% 3.0 GHz = 3.0E9 Hz [mJy]
VLASS_flux = Table{7}; 
VLASS_flux_err = Table{8}; 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % spectral index fitting of NVSS and VLASS
% unique_name = unique(name);
% 
% for i = 1:length(unique_name)    %%%length(name)
%     
% %     %%% spectral index fitted by Matlab function
% %     func = fittype('C*nu^(-alp)','coefficients',{'C','alp'},'independent',{'nu'}); 
% %     %func = fittype('(-alp)*nu','coefficients',{'alp'},'independent',{'nu'}); 
% % 
% %     x = [1.4E9, 3.0E9];
% %     y = [NVSS_flux(i), VLASS_flux(i)/1000];
% %     
% %     %%% spectral index fitting
% %     startPoint = [1.0E-23, 0];
% %     fit_res = fit(x', y',func, 'Start', startPoint,'TolX', 1E-15);  % 
% % 
% %     %point1 = fit_res.C*x(1)^(-fit_res.alp)
% %     %point2 = fit_res.C*x(2)^(-fit_res.alp)
% % 
% %     alp_array(i) = fit_res.alp';
% 
%     %%% Spectral index calculated by myself
%     name_index = find(name == unique_name(i));
%     
%     NVSS_flux_array(i) = NVSS_flux(name_index(1));
%     VLASS_sumflux(i) = sum(VLASS_flux(name_index)/1000);
% 
%     flux_ratio = log10(NVSS_flux(name_index(1)))-log10(sum(VLASS_flux(name_index)/1000));
%     nu_ratio = log10(1.4E9)-log10(3.0E9);
%     alp_calculate = flux_ratio/nu_ratio;
%     
%     alp_array(i) = alp_calculate;
%  end
% 
%  NVSS_flux_array = NVSS_flux_array';
%  VLASS_sumflux = VLASS_sumflux';
%  alp_array = alp_array';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%%% spectral index fitting of NVSS and OVRO
unique_name = unique(name);

fileFolder = fullfile(['/Users/87steven/Documents/ASIAA/Radio variability Code/lightcurvesflagged']);    
dirOutput = dir(fullfile(fileFolder,'*'));
have_lightcurve_Name = {dirOutput.name}';  

for i = 1:length(unique_name)    %%%length(name)
    
    for j = 1:length(have_lightcurve_Name)

        if strcmp([unique_name(i)+'.csv'], have_lightcurve_Name{j,1}) == 1
            
                have_alpha_name(j) = unique_name(i);

                data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/lightcurvesflagged/',unique_name(i),'.csv'); 
                fid = fopen(data);  % openfile
            
                for k = 1:1
                    fgetl(fid);  % skip header of first line
                end
            
                Table = textscan(fid,'%s %f %f','delimiter',','); 
                fclose(fid); 
            
                OVRO_flux = Table{2}; 
                OVRO_flux_err = Table{3};   %% 1.4 GHz = 1.4E9 Hz [flux unit: Jy]
                
                OVRO_meanflux = nanmean(OVRO_flux);
            
                %%% Spectral index calculated by myself
                name_index = find(name == unique_name(i));
                have_alpha_nvss(j) = NVSS_flux(name_index(1));
                have_alpha_ovro(j) = OVRO_meanflux;
            
                flux_ratio = log10(NVSS_flux(name_index(1)))-log10(OVRO_meanflux);
                nu_ratio = log10(1.4E9)-log10(15E9);
                alp_calculate = flux_ratio/nu_ratio;
                
                alp_array(j) = alp_calculate;

        end

    end

 end

have_alpha_name = have_alpha_name';
have_alpha_nvss = have_alpha_nvss';
have_alpha_ovro = have_alpha_ovro';
alp_array = alp_array';
%%
%%% find source flux with large spectral index
index = find(alp_array>2 & alp_array<10);

large_alpha = alp_array(index);
large_alpha_name = name(index);
large_alpha_NVSS_dis = NVSS_dis(index);
large_alpha_NVSS = NVSS_flux(index);
large_alpha_VLASS_dis = VLASS_dis(index);
large_alpha_VLASS = VLASS_flux(index)./1000;

%% plot figure to check if model fitted line is consist with data points
%%% define plotting line and points
freq = linspace(1.4E9, 3.0E9, 2);
flux = fit_res.C*freq.^(-fit_res.alp)*1.0E-23; % line from fit
%flux = -fit_res.alp.*log10(freq); % line from fit

flux_ratio = log10(NVSS_flux(i))-log10(VLASS_flux(i)/1000);
nu_ratio = log10(3.0E9)-log10(1.4E9);
alp_calculate = flux_ratio/nu_ratio;
flux_cal = fit_res.C*freq.^(-alp_calculate)*5.13E-23; % line from fit

Fnu = y*1.0E-23; % [erg/s/cm^2/Hz]

figure(1);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(log10(x), log10(Fnu),'go','MarkerSize',5,'MarkerFaceColor','g') %% data point
    hold on 
    plot(log10(freq), log10(flux),'r-','LineWidth',2) %% line from fit
    plot(log10(freq), log10(flux_cal),'b-','LineWidth',2) %% line from fit
    hold off

    xlim([9.0 9.5])
    %ylim([0.01*min(Fnu) 1.2*max(Fnu)])   
    xlabel('log(\nu) [Hz]','FontSize', 15)
    ylabel('log(F(\nu)) [erg/s/cm^{2}/Hz]','FontSize', 15)   
    set(gca,'FontSize',15,'LineWidth',2) 
    grid on

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% correlation test between spectral index and variability timescale and amplitude
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Read data
clc; clear; close all;

%data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/OVRO spectral index data/OVRO timescale & spectral index NVSS VLASS.csv'); 
data = strcat('/Users/87steven/Documents/ASIAA/Radio variability Code/OVRO spectral index data/OVRO timescale & spectral index NVSS OVRO.csv'); 

fid = fopen(data);  % openfile

for i = 1:1
    fgetl(fid);  % skip header of first line
end

Table = textscan(fid,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f','delimiter',','); 
fclose(fid); 

name = string( Table{1} );  
tau_char_unweighted = Table{2};
Dnoise = Table{3}; 
tau_char = Table{4}; 
tau_char_uperr = Table{5};   
tau_char_loerr = Table{6}; 
D1000 = Table{7}; 
D1000_uperr = Table{8}; 
D1000_loerr = Table{9};
D4 = Table{10}; 
D4_uperr = Table{11}; 
D4_loerr = Table{12};
alpha = Table{13};
z = Table{14}; 
% alpha = Table{12}; % spectral index of VLA and NVSS ""DONT USE""

%%
%%% spectral index against Characteristic timescale 
index1 = find(tau_char ~= tau_char_unweighted);
index2 = find(tau_char == tau_char_unweighted);

[r1,p1] = corr(alpha(index1),tau_char(index1),'type','Spearman','rows','complete');

figure(1);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(alpha(index1),tau_char(index1),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    %errorbar(alpha,tau_char,tau_char-tau_char_loerr,tau_char_uperr-tau_char,'r.','MarkerSize',6,'MarkerFaceColor','k','CapSize',0)
    plot(alpha(index2),tau_char(index2),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([min(alpha) 1.2])  
    ylim([min(tau_char)*0.5 max(tau_char)*1.1]) 
    xlabel('Spectral Index (\alpha)','FontSize', 20) 
    ylabel('Characteristic Timescale (\tau_{char})','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    %set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4f'], r1, p1);
    text(0.8,3500,context,'FontSize', 20)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
tau_char_real  = tau_char(index1);
alpha_real = alpha(index1);
x1 = find(tau_char_real >= nanmedian(tau_char_real)); 
x2 = find(tau_char_real < nanmedian(tau_char_real)); 

[r, p] = kstest2(alpha_real(x1), alpha_real(x2));

figure(51)
set(gcf,'pos',[100,100,1200,800]);
%ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
%ax2.PositionConstraint = 'innerposition';

    histogram(alpha_real(x1),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(alpha_real(x2),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(alpha_real(x1)),nanmedian(alpha_real(x1))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(alpha_real(x2)),nanmedian(alpha_real(x2))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf(' \\tau_{char} > %4.fd', median(tau_char_real)), sprintf('\\tau_{char} < %4.fd', median(tau_char_real)), ...
        'location','northwest','FontSize', 20)
    xlabel('Spectral Index (\alpha)','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-2 2.5])
    ylim([0 0.2])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-1.8, 0.23,context,'FontSize', 25)

%saveas(gcf,['/Users/87steven/Downloads/paper figures/spectral index distributed by characteristic timescale.png']);

%%
%%% spectral index against Intrinsic timescale 
index1 = find(tau_char ~= tau_char_unweighted);
index2 = find(tau_char == tau_char_unweighted);

[r1,p1] = corr(alpha(index1),tau_char(index1).*(1+z(index1)),'type','Spearman','rows','complete');

figure(2);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(alpha(index1),tau_char(index1).*(1+z(index1)),'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    %errorbar(alpha,tau_char,tau_char-tau_char_loerr,tau_char_uperr-tau_char,'r.','MarkerSize',6,'MarkerFaceColor','k','CapSize',0)
    plot(alpha(index2),tau_char(index2).*(1+z(index2)),'g^','MarkerSize',5,'MarkerFaceColor','g') 
    hold off
    xlim([min(alpha)*0.8 max(alpha)*1.2])  
    ylim([min(tau_char)*0.5 max(tau_char.*(1+z))*1.1]) 
    xlabel('Spectral Index (\alpha)','FontSize', 20) 
    ylabel('Intrinsic Timescale (\tau_{src})','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    %set(gca,'XScale','log','YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4f'], r1, p1);
    text(-0.3,14000,context,'FontSize', 20)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
tau_char_real  = tau_char(index1).*(1+z(index1));
alpha_real = alpha(index1);
x1 = find(tau_char_real >= nanmedian(tau_char_real)); 
x2 = find(tau_char_real < nanmedian(tau_char_real)); 

[r, p] = kstest2(alpha_real(x1),alpha_real(x2));

figure(52)
set(gcf,'pos',[100,100,1200,800]);
%ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
%ax2.PositionConstraint = 'innerposition';

    histogram(alpha_real(x1),15,'binwidth',0.25,'Normalization','probability')
    hold on
    histogram(alpha_real(x2),15,'binwidth',0.25,'Normalization','probability')
    plot([nanmedian(alpha_real(x1)),nanmedian(alpha_real(x1))],[0,1],'b--','LineWidth',4)
    plot([nanmedian(alpha_real(x2)),nanmedian(alpha_real(x2))],[0,1],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf(' \\tau_{src} > %3.fd', nanmedian(tau_char_real)), sprintf('\\tau_{src} < %3.fd', nanmedian(tau_char_real)), ...
        'location','northwest','FontSize', 20)
    xlabel('Spectral Index (\alpha)','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    xlim([-2 2.5])
    ylim([0 0.2])
    set(gca,'FontSize',20,'LineWidth',2);

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-0.6,0.23,context,'FontSize', 25)
%saveas(gcf,['/Users/87steven/Downloads/paper figures/spectral index distributed by intrinsic timescale.png']);

%%
%%% spectral index against variability amplitude

[r2,p2] = corr(alpha,D1000,'type','Spearman','rows','complete');

figure(3);
    set(gcf,'pos',[100,100,1200,800]);
    
    plot(alpha,D1000,'ro','MarkerSize',5,'MarkerFaceColor','r') 
    hold on 
    errorbar(alpha,D1000,D1000-D1000_loerr,D1000_uperr-D1000,'r.','MarkerSize',6,'MarkerFaceColor','k','CapSize',0,'LineWidth',2)
    hold off
    xlim([-0.8 1])  % xlim([-1. max(alpha)*1.])  
    ylim([0 max(D1000)*1.1]) 
    xlabel('Spectral Index (\alpha)','FontSize', 20) 
    ylabel('SF Amplitude (D(\tau=1000))','FontSize', 20) 
    set(gca,'FontSize',20,'LineWidth',2); 
    set(gca,'YScale','log');

    context = sprintf(['Spearman correlation result:\n r = %4.2f,\n p = %6.4f'], r2, p2);
    text(-0.7,1,context,'FontSize', 20)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
%%% Distribute D(1000 d) by the spectral index
%x1 = find(D1000 >= nanmedian(D1000)); 
%x2 = find(D1000 < nanmedian(D1000)); 

x1 = find(alpha >= -0.5); 
x2 = find(alpha < -0.5); 
D1000(D1000 < 0) = NaN;

[r, p] = kstest2(D1000(x1),D1000(x2));

figure(53)
set(gcf,'pos',[100,100,1200,800]);
%ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
%ax2.PositionConstraint = 'innerposition';

    histogram(log10(D1000(x1)),15,'binwidth',0.25,'Normalization','probability') % ,'Normalization','probability'
    hold on
    histogram(log10(D1000(x2)),15,'binwidth',0.25,'Normalization','probability') % ,'Normalization','probability'
    plot([nanmedian(log10(D1000(x1))),nanmedian(log10(D1000(x1)))],[0,1000],'b--','LineWidth',4)
    plot([nanmedian(log10(D1000(x2))),nanmedian(log10(D1000(x2)))],[0,1000],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('\\alpha > 0'), sprintf('\\alpha < 0'), ...
        'location','northwest','FontSize', 20)
    xlabel('SF Amplitude (D(\tau=1000))','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    %ylabel('Count','FontSize', 20)
    xlim([-3 0.])
    ylim([-0 0.4])
    set(gca,'FontSize',20,'LineWidth',2);
    %set(gca,'XScale','log');

    context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    text(-2.9,0.33,context,'FontSize', 20)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Two smaple K-S test
%%% Distribute spectral index by the median of D(1000 d)

D1000(D1000 < 0) = NaN;
x1 = find(D1000 >= nanmedian(D1000)); 
x2 = find(D1000 < nanmedian(D1000)); 

[r, p] = kstest2(alpha(x1), alpha(x2));

figure(4)
set(gcf,'pos',[100,100,1200,800]);
ax2 = axes('Position',[0.08 0.1 0.90 0.88]);
ax2.PositionConstraint = 'innerposition';

    histogram(alpha(x1),15,'binwidth',0.1,'Normalization','probability') % ,'Normalization','probability'
    hold on
    histogram(alpha(x2),15,'binwidth',0.1,'Normalization','probability') % ,'Normalization','probability'
    plot([nanmedian(alpha(x1)),nanmedian(alpha(x1))],[0,1000],'b--','LineWidth',4)
    plot([nanmedian(alpha(x2)),nanmedian(alpha(x2))],[0,1000],'--', ...
        'color',[0.8500 0.3250 0.0980],'LineWidth',4)
    hold off
    legend( sprintf('D(1000 d) > %6.4f', nanmedian(D1000)), sprintf('D(1000 d) < %6.4f', nanmedian(D1000)), ...
        'location','northwest','FontSize', 20)
    xlabel('Spectral Index (\alpha)','FontSize', 20)
    ylabel('Normalized Frequency','FontSize', 20)
    %ylabel('Count','FontSize', 20)
    xlim([-0.7 1])
    ylim([-0 0.2])
    set(gca,'FontSize',20,'LineWidth',2);
    %set(gca,'XScale','log');

    %context = sprintf(['Two Sample K-S test result:\n r = %4.2f,\n p = %6.4e'], r, p);
    %text(-0.7,0.33,context,'FontSize', 20)
%%

freq = [8, 9, 10, 11, 12, 13, 14];
flux = freq.^1.5;

figure(4)
set(gcf,'pos',[100,100,1200,800])

    plot(freq, flux,'r-','MarkerSize',5,'MarkerFaceColor','r','LineWidth',2) 

    xlabel('frequency','FontSize', 20)
    ylabel('Flux','FontSize', 20)

    set(gca,'FontSize',20,'LineWidth',2);











